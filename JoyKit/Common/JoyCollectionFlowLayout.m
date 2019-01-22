//
//  JoyCollectionFlowLayout.m
//  JoyKit_Example
//
//  Created by Joymake on 2019/1/21.
//  Copyright © 2019年 joy-make. All rights reserved.
//

#import "JoyCollectionFlowLayout.h"

@implementation JoyCollectionFlowLayout

-(instancetype)init{
    return [self initWithType:AlignWithCenter];
}

-(instancetype)initWithType:(AlignType)cellType{
    self = [super init];
    if (self){
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumLineSpacing = 10;
        self.minimumInteritemSpacing = 10;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _cellType = cellType;
    }
    return self;
}

- (void)updateFrameStartIndex:(int)startIndex breakIndex:(int)breakIndex sumWidth:(CGFloat)itemSumWidth layoutAttributes:(NSArray *)layoutAttributes{
    CGFloat startOriginX = (self.collectionView.frame.size.width-itemSumWidth-self.minimumInteritemSpacing*(breakIndex-startIndex+1)-self.sectionInset.left-self.sectionInset.right)/2+self.sectionInset.left+self.minimumInteritemSpacing;
    switch (_cellType) {
        case AlignWithLeft:
            startOriginX = self.sectionInset.left+self.minimumInteritemSpacing;
            break;
        case AlignWithCenter:
            startOriginX = (self.collectionView.frame.size.width-itemSumWidth-self.minimumInteritemSpacing*(breakIndex-startIndex+1)-self.sectionInset.left-self.sectionInset.right)/2+self.sectionInset.left+self.minimumInteritemSpacing;
            break;
        case AlignWithRight:
            startOriginX = self.collectionView.frame.size.width-itemSumWidth-self.minimumInteritemSpacing*(breakIndex-startIndex+1)-self.sectionInset.left-self.sectionInset.right;
            break;
    }
    
    for (int i=startIndex; i<(breakIndex+1); i++) {
        UICollectionViewLayoutAttributes *currentAttr = layoutAttributes[i];
        CGRect newFrame = currentAttr.frame;
        newFrame.origin.x = startOriginX;
        currentAttr.frame = newFrame;
        startOriginX = newFrame.origin.x + newFrame.size.width+self.minimumInteritemSpacing;
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray * layoutAttributes_t = [super layoutAttributesForElementsInRect:rect];
    NSArray * layoutAttributes = [[NSArray alloc]initWithArray:layoutAttributes_t copyItems:YES];
    int startIndex = 0;
    CGFloat itemSumWidth = 0;
    for (int i =0; i<layoutAttributes.count; i++) {
        UICollectionViewLayoutAttributes *currentAttr = layoutAttributes[i];
        UICollectionViewLayoutAttributes *nextAttr = layoutAttributes.count>(i+1)?layoutAttributes[i+1]:nil;
        if ([currentAttr.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]||[currentAttr.representedElementKind isEqualToString:UICollectionElementKindSectionFooter]){
            itemSumWidth = 0.0;
            startIndex = i+1;
        }else if ([nextAttr.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]||[nextAttr.representedElementKind isEqualToString:UICollectionElementKindSectionFooter]){
            UICollectionViewLayoutAttributes *currentAttr = layoutAttributes[i];
            itemSumWidth += (currentAttr.frame.size.width);
            [self updateFrameStartIndex:startIndex breakIndex:i sumWidth:itemSumWidth layoutAttributes:layoutAttributes];
            itemSumWidth = 0.0;
            startIndex = i+1;
        } else if (nextAttr.frame.origin.y<(currentAttr.frame.origin.y+currentAttr.frame.size.height)) {
            itemSumWidth += (currentAttr.frame.size.width);
            if(i == layoutAttributes.count-1 ){
                [self updateFrameStartIndex:startIndex breakIndex:i sumWidth:itemSumWidth layoutAttributes:layoutAttributes];
                itemSumWidth = 0.0;
                startIndex = i+1;
            }
        }else{
            UICollectionViewLayoutAttributes *currentAttr = layoutAttributes[i];
            itemSumWidth += (currentAttr.frame.size.width);
            [self updateFrameStartIndex:startIndex breakIndex:i sumWidth:itemSumWidth layoutAttributes:layoutAttributes];
            itemSumWidth = 0.0;
            startIndex = i+1;
        }
    }
    return layoutAttributes;
}

@end
