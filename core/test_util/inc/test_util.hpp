#ifndef TEST_UTIL_HPP
#define TEST_UTIL_HPP

#include <cstdlib>

inline void trivial_assert(bool condition) {
    if (!condition) {
        std::exit(1);
    }
}

#endif
