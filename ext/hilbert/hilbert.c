#include "hilbert.h"
#include <stdio.h>
#define Need_Float(x) do {if (!RB_TYPE_P(x, T_FLOAT)) {(x) = rb_to_float(x);}} while(0)
#define GET_FLOAT(x) Need_Float(x);(x) = RFLOAT_VALUE(x)

double func(double x)
{
  return((x * x) * 3);
}

static VALUE
rb_func(VALUE self, VALUE x)
{
  GET_FLOAT(x);
  return(DBL2NUM((x * x)/2));
}


static VALUE
execute(VALUE self, VALUE a, VALUE b, VALUE n)
{
  GET_FLOAT(a);
  GET_FLOAT(b);
  GET_FLOAT(n);

  int i;
  double s1=0.0, s2=0.0, d;
  double x, y[n+1];
  d=(b-a)/(double)n;
  for(i=0; i<=n; i++)
  {
    x=(double)i*d+a;
    y[i]=func(x);
  }
  for(i=1; i<=n-1; i+=2)
  {
    s1+=y[i];
  }
  for(i=2; i<=n-2; i+=2)
  {
    s2+=y[i];
  }

  double s=(y[0]+4.0*s1+2.0*s2+y[n])*d/3.0;

  return DBL2NUM(s);
}



void
Init_hilbert(void)
{
  VALUE rb_mHilbertMatrix = rb_define_class("HilbertMatrix", rb_cObject);
  rb_define_method(rb_mHilbertMatrix, "execute", execute, 3);
  rb_define_method(rb_mHilbertMatrix, "func", rb_func, 1);
}

// VALUE rb_mHilbertMatrix;

// void
// Init_q_matrix(void)
// {
//   rb_mHilbertMatrix = rb_define_module("HilbertMatrix");
// }
