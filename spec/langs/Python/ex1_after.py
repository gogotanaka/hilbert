from __future__ import division, print_function, absolute_import

__all__ = ['fixed_quad','quadrature','romberg','trapz','simps','romb',
           'cumtrapz','newton_cotes']

from scipy.special.orthogonal import p_roots
from scipy.special import gammaln
from numpy import sum, ones, add, diff, isinf, isscalar, \
     asarray, real, trapz, arange, empty
import numpy as np
import math
import warnings

from scipy.lib.six import xrange


class AccuracyWarning(Warning):
    pass


def _cached_p_roots(n):

    if n in _cached_p_roots.cache:
        return _cached_p_roots.cache[n]

    _cached_p_roots.cache[n] = p_roots(n)
    return _cached_p_roots.cache[n]
_cached_p_roots.cache = dict()


def fixed_quad(func,a,b,args=(),n=5):

    [x,w] = _cached_p_roots(n)
    x = real(x)
    ainf, binf = map(isinf,(a,b))
    if ainf or binf:
        raise ValueError("Gaussian quadrature is only available for "
                "finite limits.")
    y = (b-a)*(x+1)/2.0 + a
    return (b-a)/2.0*sum(w*func(y,*args),0), None


def vectorize1(func, args=(), vec_func=False):
    if vec_func:
        def vfunc(x):
            return func(x, *args)
    else:
        def vfunc(x):
            if isscalar(x):
                return func(x, *args)
            x = asarray(x)
            # call with first point to get output type
            y0 = func(x[0], *args)
            n = len(x)
            if hasattr(y0, 'dtype'):
                output = empty((n,), dtype=y0.dtype)
            else:
                output = empty((n,), dtype=type(y0))
            output[0] = y0
            for i in xrange(1, n):
                output[i] = func(x[i], *args)
            return output
    return vfunc


def quadrature(func, a, b, args=(), tol=1.49e-8, rtol=1.49e-8, maxiter=50,
               vec_func=True, miniter=1):

    if not isinstance(args, tuple):
        args = (args,)
    vfunc = vectorize1(func, args, vec_func=vec_func)
    val = np.inf
    err = np.inf
    maxiter = max(miniter+1, maxiter)
    for n in xrange(miniter, maxiter+1):
        newval = fixed_quad(vfunc, a, b, (), n)[0]
        err = abs(newval-val)
        val = newval

        if err < tol or err < rtol*abs(val):
            break
    else:
        warnings.warn(
            "maxiter (%d) exceeded. Latest difference = %e" % (maxiter, err),
            AccuracyWarning)
    return val, err


def tupleset(t, i, value):
    l = list(t)
    l[i] = value
    return tuple(l)


def cumtrapz(y, x=None, dx=1.0, axis=-1, initial=None):
    y = asarray(y)
    if x is None:
        d = dx
    else:
        x = asarray(x)
        if x.ndim == 1:
            d = diff(x)
            # reshape to correct shape
            shape = [1] * y.ndim
            shape[axis] = -1
            d = d.reshape(shape)
        elif len(x.shape) != len(y.shape):
            raise ValueError("If given, shape of x must be 1-d or the "
                    "same as y.")
        else:
            d = diff(x, axis=axis)

        if d.shape[axis] != y.shape[axis] - 1:
            raise ValueError("If given, length of x along axis must be the "
                             "same as y.")

    nd = len(y.shape)
    slice1 = tupleset((slice(None),)*nd, axis, slice(1, None))
    slice2 = tupleset((slice(None),)*nd, axis, slice(None, -1))
    res = add.accumulate(d * (y[slice1] + y[slice2]) / 2.0, axis)

    if initial is not None:
        if not np.isscalar(initial):
            raise ValueError("`initial` parameter should be a scalar.")

        shape = list(res.shape)
        shape[axis] = 1
        res = np.concatenate([np.ones(shape, dtype=res.dtype) * initial, res],
                             axis=axis)

    return res


def _basic_simps(y,start,stop,x,dx,axis):
    nd = len(y.shape)
    if start is None:
        start = 0
    step = 2
    all = (slice(None),)*nd
    slice0 = tupleset(all, axis, slice(start, stop, step))
    slice1 = tupleset(all, axis, slice(start+1, stop+1, step))
    slice2 = tupleset(all, axis, slice(start+2, stop+2, step))

    if x is None:  # Even spaced Simpson's rule.
        result = add.reduce(dx/3.0 * (y[slice0]+4*y[slice1]+y[slice2]),
                                    axis)
    else:
        # Account for possibly different spacings.
        #    Simpson's rule changes a bit.
        h = diff(x,axis=axis)
        sl0 = tupleset(all, axis, slice(start, stop, step))
        sl1 = tupleset(all, axis, slice(start+1, stop+1, step))
        h0 = h[sl0]
        h1 = h[sl1]
        hsum = h0 + h1
        hprod = h0 * h1
        h0divh1 = h0 / h1
        result = add.reduce(hsum/6.0*(y[slice0]*(2-1.0/h0divh1) +
                                              y[slice1]*hsum*hsum/hprod +
                                              y[slice2]*(2-h0divh1)),axis)
    return result


def simps(y, x=None, dx=1, axis=-1, even='avg'):

    y = asarray(y)
    nd = len(y.shape)
    N = y.shape[axis]
    last_dx = dx
    first_dx = dx
    returnshape = 0
    if x is not None:
        x = asarray(x)
        if len(x.shape) == 1:
            shapex = ones(nd)
            shapex[axis] = x.shape[0]
            saveshape = x.shape
            returnshape = 1
            x = x.reshape(tuple(shapex))
        elif len(x.shape) != len(y.shape):
            raise ValueError("If given, shape of x must be 1-d or the "
                    "same as y.")
        if x.shape[axis] != N:
            raise ValueError("If given, length of x along axis must be the "
                    "same as y.")
    if N % 2 == 0:
        val = 0.0
        result = 0.0
        slice1 = (slice(None),)*nd
        slice2 = (slice(None),)*nd
        if even not in ['avg', 'last', 'first']:
            raise ValueError("Parameter 'even' must be 'avg', 'last', or 'first'.")
        # Compute using Simpson's rule on first intervals
        if even in ['avg', 'first']:
            slice1 = tupleset(slice1, axis, -1)
            slice2 = tupleset(slice2, axis, -2)
            if x is not None:
                last_dx = x[slice1] - x[slice2]
            val += 0.5*last_dx*(y[slice1]+y[slice2])
            result = _basic_simps(y,0,N-3,x,dx,axis)
        # Compute using Simpson's rule on last set of intervals
        if even in ['avg', 'last']:
            slice1 = tupleset(slice1, axis, 0)
            slice2 = tupleset(slice2, axis, 1)
            if x is not None:
                first_dx = x[tuple(slice2)] - x[tuple(slice1)]
            val += 0.5*first_dx*(y[slice2]+y[slice1])
            result += _basic_simps(y,1,N-2,x,dx,axis)
        if even == 'avg':
            val /= 2.0
            result /= 2.0
        result = result + val
    else:
        result = _basic_simps(y,0,N-2,x,dx,axis)
    if returnshape:
        x = x.reshape(saveshape)
    return result


def romb(y, dx=1.0, axis=-1, show=False):

    y = asarray(y)
    nd = len(y.shape)
    Nsamps = y.shape[axis]
    Ninterv = Nsamps-1
    n = 1
    k = 0
    while n < Ninterv:
        n <<= 1
        k += 1
    if n != Ninterv:
        raise ValueError("Number of samples must be one plus a "
                "non-negative power of 2.")

    R = {}
    all = (slice(None),) * nd
    slice0 = tupleset(all, axis, 0)
    slicem1 = tupleset(all, axis, -1)
    h = Ninterv*asarray(dx)*1.0
    R[(0,0)] = (y[slice0] + y[slicem1])/2.0*h
    slice_R = all
    start = stop = step = Ninterv
    for i in range(1,k+1):
        start >>= 1
        slice_R = tupleset(slice_R, axis, slice(start,stop,step))
        step >>= 1
        R[(i,0)] = 0.5*(R[(i-1,0)] + h*add.reduce(y[slice_R],axis))
        for j in range(1,i+1):
            R[(i,j)] = R[(i,j-1)] + \
                       (R[(i,j-1)]-R[(i-1,j-1)]) / ((1 << (2*j))-1)
        h = h / 2.0

    if show:
        if not isscalar(R[(0,0)]):
            print("*** Printing table only supported for integrals" +
                  " of a single data set.")
        else:
            try:
                precis = show[0]
            except (TypeError, IndexError):
                precis = 5
            try:
                width = show[1]
            except (TypeError, IndexError):
                width = 8
            formstr = "%" + str(width) + '.' + str(precis)+'f'

            print("\n       Richardson Extrapolation Table for Romberg Integration       ")
            print("====================================================================")
            for i in range(0,k+1):
                for j in range(0,i+1):
                    print(formstr % R[(i,j)], end=' ')
                print()
            print("====================================================================\n")

    return R[(k,k)]


def _difftrap(function, interval, numtraps):
    if numtraps <= 0:
        raise ValueError("numtraps must be > 0 in difftrap().")
    elif numtraps == 1:
        return 0.5*(function(interval[0])+function(interval[1]))
    else:
        numtosum = numtraps/2
        h = float(interval[1]-interval[0])/numtosum
        lox = interval[0] + 0.5 * h
        points = lox + h * arange(0, numtosum)
        s = sum(function(points),0)
        return s


def _romberg_diff(b, c, k):

    tmp = 4.0**k
    return (tmp * c - b)/(tmp - 1.0)


def _printresmat(function, interval, resmat):
    # Print the Romberg result matrix.
    i = j = 0
    print('Romberg integration of', repr(function), end=' ')
    print('from', interval)
    print('')
    print('%6s %9s %9s' % ('Steps', 'StepSize', 'Results'))
    for i in range(len(resmat)):
        print('%6d %9f' % (2**i, (interval[1]-interval[0])/(2.**i)), end=' ')
        for j in range(i+1):
            print('%9f' % (resmat[i][j]), end=' ')
        print('')
    print('')
    print('The final result is', resmat[i][j], end=' ')
    print('after', 2**(len(resmat)-1)+1, 'function evaluations.')


def romberg(function, a, b, args=(), tol=1.48e-8, rtol=1.48e-8, show=False,
            divmax=10, vec_func=False):
    if isinf(a) or isinf(b):
        raise ValueError("Romberg integration only available for finite limits.")
    vfunc = vectorize1(function, args, vec_func=vec_func)
    n = 1
    interval = [a,b]
    intrange = b-a
    ordsum = _difftrap(vfunc, interval, n)
    result = intrange * ordsum
    resmat = [[result]]
    err = np.inf
    for i in xrange(1, divmax+1):
        n = n * 2
        ordsum = ordsum + _difftrap(vfunc, interval, n)
        resmat.append([])
        resmat[i].append(intrange * ordsum / n)
        for k in range(i):
            resmat[i].append(_romberg_diff(resmat[i-1][k], resmat[i][k], k+1))
        result = resmat[i][i]
        lastresult = resmat[i-1][i-1]

        err = abs(result - lastresult)
        if err < tol or err < rtol*abs(result):
            break
    else:
        warnings.warn(
            "divmax (%d) exceeded. Latest difference = %e" % (divmax, err),
            AccuracyWarning)

    if show:
        _printresmat(vfunc, interval, resmat)
    return result

_builtincoeffs = {
    1:(1,2,[1,1],-1,12),
    2:(1,3,[1,4,1],-1,90),
    3:(3,8,[1,3,3,1],-3,80),
    4:(2,45,[7,32,12,32,7],-8,945),
    5:(5,288,[19,75,50,50,75,19],-275,12096),
    6:(1,140,[41,216,27,272,27,216,41],-9,1400),
    7:(7,17280,[751,3577,1323,2989,2989,1323,3577,751],-8183,518400),
    8:(4,14175,[989,5888,-928,10496,-4540,10496,-928,5888,989],
       -2368,467775),
    9:(9,89600,[2857,15741,1080,19344,5778,5778,19344,1080,
                15741,2857], -4671, 394240),
    10:(5,299376,[16067,106300,-48525,272400,-260550,427368,
                  -260550,272400,-48525,106300,16067],
        -673175, 163459296),
    11:(11,87091200,[2171465,13486539,-3237113, 25226685,-9595542,
                     15493566,15493566,-9595542,25226685,-3237113,
                     13486539,2171465], -2224234463, 237758976000),
    12:(1, 5255250, [1364651,9903168,-7587864,35725120,-51491295,
                     87516288,-87797136,87516288,-51491295,35725120,
                     -7587864,9903168,1364651], -3012, 875875),
    13:(13, 402361344000,[8181904909, 56280729661, -31268252574,
                          156074417954,-151659573325,206683437987,
                          -43111992612,-43111992612,206683437987,
                          -151659573325,156074417954,-31268252574,
                          56280729661,8181904909], -2639651053,
        344881152000),
    14:(7, 2501928000, [90241897,710986864,-770720657,3501442784,
                        -6625093363,12630121616,-16802270373,19534438464,
                        -16802270373,12630121616,-6625093363,3501442784,
                        -770720657,710986864,90241897], -3740727473,
        1275983280000)
    }


def newton_cotes(rn, equal=0):
    try:
        N = len(rn)-1
        if equal:
            rn = np.arange(N+1)
        elif np.all(np.diff(rn) == 1):
            equal = 1
    except:
        N = rn
        rn = np.arange(N+1)
        equal = 1

    if equal and N in _builtincoeffs:
        na, da, vi, nb, db = _builtincoeffs[N]
        return na*np.array(vi,float)/da, float(nb)/db

    if (rn[0] != 0) or (rn[-1] != N):
        raise ValueError("The sample positions must start at 0"
                " and end at N")
    yi = rn / float(N)
    ti = 2.0*yi - 1
    nvec = np.arange(0,N+1)
    C = ti**nvec[:,np.newaxis]
    Cinv = np.linalg.inv(C)
    # improve precision of result
    for i in range(2):
        Cinv = 2*Cinv - Cinv.dot(C).dot(Cinv)
    vec = 2.0 / (nvec[::2]+1)
    ai = np.dot(Cinv[:,::2],vec) * N/2

    if (N % 2 == 0) and equal:
        BN = N/(N+3.)
        power = N+2
    else:
        BN = N/(N+2.)
        power = N+1

    BN = BN - np.dot(yi**power, ai)
    p1 = power+1
    fac = power*math.log(N) - gammaln(p1)
    fac = math.exp(fac)
    return ai, BN*fac
