#include "qlang.h"

VALUE rb_mQlang;

void
Init_qlang(void)
{
  rb_mQlang = rb_define_module("Qlang");
}
