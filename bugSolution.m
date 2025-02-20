The solution involves using `__weak` or `__strong` within the block to properly manage the object's lifecycle: 

```objectivec
- (void)someMethod {
    __weak typeof(self) weakSelf = self; // weak reference to avoid retain cycles 
    [self.dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        __strong typeof(obj) strongObj = obj; //create a strong reference to make sure it exists in block duration
        if (strongObj) { //Check for null to avoid crash
            // ... some code that modifies strongObj ...
        }
    }];
}
```

This ensures that `strongObj` is retained during the block's execution, preventing the EXC_BAD_ACCESS error.  The `weakSelf` helps avoid retain cycles that may occur if `self` retains the block.  Always check `strongObj` for null before using to prevent crashes.