//
//  BNRItem.m
//  RandomPossessions
//
//  Created by Joe Conway on 10/12/12.
//  Copyright (c) 2012 Big Nerd Ranch. All rights reserved.
//

#import "BNRItem.h"
#import "BNRDetailViewController.h"
#import "BNRImageStore.h"
@interface BNRItem ()

@property (nonatomic, strong) NSDate *dateCreated;

@end

@implementation BNRItem

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.itemName forKey:@"itemName"];
    [aCoder encodeObject:self.serialNumber forKey:@"serialNumber"];
    [aCoder encodeObject:self.dateCreated forKey:@"dateCreated"];
    [aCoder encodeObject:self.itemKey forKey:@"itemKey"];
    
    [aCoder encodeInt:self.valueInDollars forKey:@"valueInDollars"];
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _itemName = [aDecoder decodeObjectForKey:@"itemName"];
        _serialNumber = [aDecoder decodeObjectForKey:@"serialNumber"];
        _dateCreated = [aDecoder decodeObjectForKey:@"dateCreated"];
        _itemKey = [aDecoder decodeObjectForKey:@"itemKey"];
        
        _valueInDollars = [aDecoder decodeIntForKey:@"valueInDollars"];
    }
    return self;
}


+ (id)randomItem
{
    // Create an array of three adjectives
    NSArray *randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny", @"Nasty", @"Sacred", @"Poor Man's", @"Magic", @"Arcane", @"Sage's"];
    // Create an array of three nouns
    NSArray *randomNounList = @[@"Bear", @"Spork", @"Mac", @"Cup", @"Book", @"Bible", @"iPhone", @"Mask", @"Blade", @"Chopsticks", @"Boots", @"Relic"];
    // Get the index of a random adjective/noun from the lists
    // Note: The % operator, called the modulo operator, gives
    // you the remainder. So adjectiveIndex is a random number
    // from 0 to 2 inclusive.
    NSInteger adjectiveIndex = rand() % [randomAdjectiveList count];
    NSInteger nounIndex = rand() % [randomNounList count];
    // Note that NSInteger is not an object, but a type definition
    // for "unsigned long"
    NSString *randomName = [NSString stringWithFormat:@"%@ %@",
                                randomAdjectiveList[adjectiveIndex],
                                randomNounList[nounIndex]];
    int randomValue = rand() % 100;
    if(rand()%2 == 1)
        randomValue += 1024;
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                        '0' + rand() % 10,
                                        'A' + rand() % 26,
                                        '0' + rand() % 10,
                                        'A' + rand() % 26,
                                        '0' + rand() % 10];
    BNRItem *newItem =
        [[self alloc] initWithItemName:randomName
                        valueInDollars:randomValue
                          serialNumber:randomSerialNumber];
    return newItem;
}

- (id)initWithItemName:(NSString *)name
        valueInDollars:(int)value
          serialNumber:(NSString *)sNumber
{
    // Call the superclass's designated initializer
    self = [super init];
    // Did the superclass's designated initializer succeed?
    if (self) {
        // Give the instance variables initial values
        self.itemName = name;
        self.serialNumber = sNumber;
        self.valueInDollars = value;
        self.dateCreated = [[NSDate alloc] init];
        
        NSUUID *uuid = [[NSUUID alloc] init];
        NSString *key = [uuid UUIDString];
        _itemKey = key;
    }
    
    // Return the address of the newly initialized object
    return self;
}

- (id)init {
    return [self initWithItemName:@"Item"
                   valueInDollars:0
                     serialNumber:@""];
}

- (NSString *)description
{
    NSString *descriptionString =
        [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorded on %@",
                            self.itemName,
                            self.serialNumber,
                            self.valueInDollars,
                            self.dateCreated];
    return descriptionString;
}

- (void)dealloc
{
    NSLog(@"Destroyed: %@", self);
}

@end
