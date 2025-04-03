import std.stdio;

import std.math : pow, log10;
import std.algorithm: canFind;
import std.conv : to;
import core.stdc.stdlib : malloc, free;
import std.datetime.stopwatch;
import std.array : Appender;

void main() {
    // Define a set of characters to be used.
    char[] charSet = ['h','e','l','o'];
    // Maximum length of generated password.
    int maximumLength = 5;

    string[] result = allCombinations(charSet, 0, maximumLength);

    // All combinations of h, e, l, and o are generated out to 5 characters. 1,024 generated strings.
    assert(result.canFind("l"));
    assert(result.canFind("eeeee"));
    assert(result.canFind("hello"));
    assert(result.canFind("olleh"));
    
    writeln("Generated count: ", result.length);

    // All capital characters A-Z
    charSet = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
    maximumLength = 5;
    result = allCombinations(charSet, 0, maximumLength);

    // All words consisting of letters from the English alphabet, which are 5 or less characters should appear in the returned list. 11,881,376 generated words.
    assert(result.canFind("ZACH"));
    assert(result.canFind("DAVIS"));
    assert(result.canFind("JOHN"));

    assert(result.canFind("MILK"));
    assert(result.canFind("EGG"));
    assert(result.canFind("CAT"));
    assert(result.canFind("APPLE"));

    assert(result.canFind("JAVA"));
    assert(result.canFind("DLANG"));

    writeln("Generated count: ", result.length);

    auto sw = StopWatch(AutoStart.no);
    
    charSet = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];

    writeln("Benchmark starting...");
    

    for (int i = 1; i < 6; i++) {
        sw.start();
        allCombinations(charSet, i);
        sw.stop();

        long msecs = sw.peek.total!"msecs";
        writeln("Charset of length " ~ to!(string)(charSet.length) ~ " and maximum password length of length " ~ to!(string)(i) ~ " took " ~ to!(string)(to!(double)(msecs)/1000) ~ " seconds");
    }

    
    writeln("Benchmark Ending...");
}

string[] allCombinations(char[] charSet, int minimumLength, int maximumLength) {
    string[] output;
    foreach (i; minimumLength..maximumLength+1) {
        output ~= allCombinations(charSet, i);
    }
    return output;
}

string[] allCombinations(char[] charSet, int maximumLength) {
    Appender!(string[]) result;
    uint base = cast(uint)(charSet.length);
    uint numberOfStrings = cast(uint)(pow(base, maximumLength));

    for (uint i = 0; i < numberOfStrings; i++) {
        string generated;
        uint temp = i;

        // Convert to base-N representation
        do {
            /* 
            Takes the number in the 1s place of i and finds the corresponding character in the charSet.
            This essentially treats charSet as a set of numbers in base n and constructs "numbers" sequentially.
            */
            generated = charSet[temp % base] ~ generated;
            temp /= base;
        } while (temp > 0);

        // Pad with leading charSet[0] to ensure correct length
        while (generated.length < maximumLength) {
            generated = charSet[0] ~ generated;
        }

        // Add generated string to the result list.
        result.put(generated);
    }

    return result.data;
}