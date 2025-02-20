# Objective-C Block and Memory Management Crash

This repository demonstrates a common and often subtle bug in Objective-C related to memory management and the use of blocks.  The bug occurs when an object referenced within a block is deallocated before the block completes its execution.  This frequently results in an EXC_BAD_ACCESS crash.

## Bug Description
The `bug.m` file shows the problematic code.  A block iterates over an array of objects. If these objects are deallocated externally before the block finishes processing, attempts to access them within the block result in a crash. 

## Solution
The `bugSolution.m` file provides a solution to this problem. By using a `__weak` or `__strong` reference to the object inside the block, we mitigate the risk of accessing deallocated memory.   Using `__weak` prevents a retain cycle; while `__strong` retains the object for the block's duration. The choice between `__weak` and `__strong` will depend on the intended lifetime of the object in relation to the block.