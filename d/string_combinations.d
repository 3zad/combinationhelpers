module d.string_combinations;

import std.stdio;
import std.conv;
import std.array;

void main() {
    writeln(everyCombination(['a', 'b', 'c']));
}

string[] everyCombination(char[] chars) {
    string[] output;

    int[] combinationHolder;
    for (int i = 0; i < chars.length; i++) {
        combinationHolder ~= 0;
    }

    bool isFull;
    string fullString;
    while (true) {
        isFull = true;
        for (int i = 0; i < combinationHolder.length; i++) {
            if (combinationHolder[i] == 0) {
                combinationHolder[i] = 1;
                isFull = false;
                break;
            }
            combinationHolder[i] = 0;
        }

        if (isFull) {
            return output;
        }

        fullString = "";
        for (int i = 0; i < combinationHolder.length; i++) {
            if (combinationHolder[i] == 1) {
                fullString ~= chars[i];
            }
        }
        
        if (fullString.length <= 1) {
            output ~= fullString;
        } else {
            output ~= findPermutation(fullString);
        }
        
    }
}


static void permute(int index, char[] s, string[]* output) {
    if (index == s.length) {
        *(output) ~= to!(string)(s);
        return;
    }

    for (int i = index; i < s.length; i++) {
        swap(s, index, i);
        permute(index + 1, s, output);
        swap(s, index, i);
    }
}

static void swap(char[] s, int i, int j) {
    char temp = s[i];
    s[i] = s[j];
    s[j] = temp;
}

static string[] findPermutation(string s) {
    string[] output = [];

    permute(0, to!(char[])(s), &output);

    return output;
}