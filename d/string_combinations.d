import std.stdio;

import std.math : pow;
import std.algorithm: canFind;

void main() {
    char[] charSet = ['h','e','l','o'];
    int maximumLength = 5;
    string[] result = allCombinations(charSet, maximumLength);

    assert(result.canFind("l"));
    assert(result.canFind("eeeee"));
    assert(result.canFind("hello"));

    // All capital characters A-Z
    charSet = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
    maximumLength = 5;
    result = allCombinations(charSet, maximumLength);

    // All words consisting of letters from the English alphabet, which are 5 or less characters should appear in the returned list.
    assert(result.canFind("ZACH"));
    assert(result.canFind("DAVIS"));
    assert(result.canFind("JOHN"));

    assert(result.canFind("MILK"));
    assert(result.canFind("EGG"));
    assert(result.canFind("CAT"));
    assert(result.canFind("APPLE"));

    assert(result.canFind("DLANG"));
}



string[] allCombinations(char[] charSet, int maximumLength) {
    string[] result;

    string generated;
    int temp;
    for (int i = 0; i < pow(charSet.length, maximumLength); i++) {
        generated = "";
        temp = i;
        while (true) {
            generated ~= charSet[temp%charSet.length];
            temp /= charSet.length;
            if (temp < 1) {
                break;
            }
        }

        result ~= generated;
    }

    return result;
}