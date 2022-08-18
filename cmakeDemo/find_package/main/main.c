#include "bar.obj.h"
#include "bar_shared.h"
#include "bar_static.h"
#include "foo_obj.h"
#include "foo_shared.h"
#include "foo_static.h"

#include <stdio.h>

int main(int argc, char const *argv[]) {
    foo_shared();
    foo_static();
    foo_obj1();
    foo_obj2();
    bar_shared();
    bar_static();
    bar_obj1();
    bar_obj2();
    return 0;
}
