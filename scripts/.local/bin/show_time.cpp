#include <string>
#include <iostream>

int main(int argc, char* argv[]) {
	if (argc < 2) { return 1; }
	auto const seconds = std::stoul(argv[1]);
	auto const minutes = seconds / 60;
	auto const hours = minutes / 60;
	auto const days = hours / 24;
	if (days > 0) {
		std::cout << days << "d ";
	}
	std::cout << hours % 24 << "h " << minutes % 60 << 'm';
	if (days == 0) {
		std::cout << ' ' << seconds % 60 << 's';
	}
	std::cout << std::endl;
	return 0;
}
