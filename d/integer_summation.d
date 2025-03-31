module d.string_combinations;

import std.stdio;
import std.algorithm : canFind;

void main() {
    writeln(everySum([2,5,10,20,50,100]));
}


int[] everySum(int[] numbers) {
    int[] output;

    int[] combinationHolder;
    for (int i = 0; i < numbers.length; i++) {
        combinationHolder ~= 0;
    }

    bool isFull;
    int sum;
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

        sum = 0;
        for (int i = 0; i < combinationHolder.length; i++) {
            if (combinationHolder[i] == 1) {
                sum += numbers[i];
            }
        }
        if (!output.canFind(sum)) {
            output ~= sum;
        }
    }
}