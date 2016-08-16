#include "foo.hpp"

#include <bar/bar.hpp>
#include <iostream>
#include <iomanip>

namespace foo {

void msg(bool verbose)
{
	std::cout << "foo::msg(verbose = " << std::boolalpha << verbose << ")\n";

	if (verbose) {
		bar::msg();
	}
}

} // namespace foo
