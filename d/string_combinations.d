import std.stdio;

import std.math : pow, log10;
import std.algorithm: canFind;
import std.conv : to;
import core.stdc.stdlib : malloc, free;

void main() {
    // Define a set of characters to be used.
    char[] charSet = ['h','e','l','o'];
    // Maximum length of generated password.
    int maximumLength = 5;

    string[] result = allCombinations(charSet, maximumLength);

    //writeln(result);

    // All combinations of h, e, l, and o are generated out to 5 characters.
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

    assert(result.canFind("JAVA"));
    assert(result.canFind("DLANG"));
}


string[] allCombinations(char[] charSet, int maximumLength) {
    size_t numberOfStrings = to!(int)(pow(charSet.length, maximumLength+1));
    string* staticResult = cast(string*) malloc(numberOfStrings * string.sizeof);

    string generated;
    int temp;

    // Definite first case otherwise the logarithm math will be messed up when i=0
    staticResult[0] = to!(string)(charSet[0]);

    // Loops while the length of the generated string is below the threshhold maximumLength.
    for (int i = 1; i < numberOfStrings; i++) {
        generated = "";

        // Temp variable for division
        temp = i;

        // Loop for log base charSet.length of i rounded down.
        for (int _ = 0; _ < to!(int)(log10(i)/log10(charSet.length))+1; _++) {
            /* 
            Takes the number in the 1s place of i and finds the corresponding character in the charSet.
            This is where the magic happens. This essentially treats charSet as a set of numbers in base
            charSet.length and constructs "numbers" sequentially.
            */
            generated ~= charSet[temp%charSet.length];
            temp /= charSet.length;
        }

        // Add generated string to the result list.
        staticResult[i] = generated;
    }

    // Create a regular dynamic array out of the static array, free the memory of the static array, then return the dynamic array.
    string[] result = staticResult[0 .. numberOfStrings];
    free(staticResult);
    return result;
}