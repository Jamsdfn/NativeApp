#import "Contact.h"

@implementation Contact

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_phoneNumber forKey:@"phone"];
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _name = [coder decodeObjectForKey:@"name"];
        _phoneNumber = [coder decodeObjectForKey:@"phone"];
    }
    return self;
}

+ (BOOL)supportsSecureCoding{
    return YES;
}


@end



