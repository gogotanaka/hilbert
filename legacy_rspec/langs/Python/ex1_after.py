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
  a = array([1, 3, 4])

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
