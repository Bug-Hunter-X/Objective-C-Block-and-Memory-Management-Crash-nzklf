In Objective-C, a common yet subtle issue arises when dealing with memory management and object lifecycles, especially when using blocks.  Consider this scenario: 

```objectivec
@property (nonatomic, strong) NSMutableArray *dataArray;

- (void)someMethod {
    [self.dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        // ... some code that modifies obj ...
        // ...potential crash here if obj is deallocated before block completes...
    }];
}
```

If `obj` is an object whose lifecycle is shorter than the block's execution, attempting to access or modify `obj` within the block after it's been deallocated will lead to a crash. This often manifests as EXC_BAD_ACCESS errors.