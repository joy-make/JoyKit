//
//  JoyTextViewCell.m
//  Pods
//
//  Created by joymake on 2017/8/11.
//
//
#define KTEXTMaXWIDTH  self.contentView.width-20
#define KTEXTMaXHEIGHT 200
#define KTEXTMINHEIGHT 34
#define KTEXTTBSPACE  10

#import "JoyTextViewCell.h"
#import "JoyCellBaseModel.h"
#import "NSString+JoyCategory.h"
#import "Joy.h"
#import "UIColor+JoyColor.h"

@interface JoyTextViewCell()<UITextViewDelegate>
@property (strong, nonatomic)  UITextView *textView;
@property (nonatomic,copy) NSString *inputOldStr;
@property (nonatomic,copy)NSString *changeTextKey;
@property (strong, nonatomic) UILabel *placeHolderLabel;
@property (nonatomic,assign)BOOL isNeedScroll;
@end

@implementation JoyTextViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.placeHolderLabel];
        [self.contentView addSubview:self.textView];
        [self setConstraint];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

-(UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectZero];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.backgroundColor = [UIColor clearColor];
    }
    return _textView;
}

-(UILabel *)placeHolderLabel{
    if(!_placeHolderLabel){
        _placeHolderLabel =[[UILabel alloc]init];
        _placeHolderLabel.font = [UIFont systemFontOfSize:15];
        _placeHolderLabel.textColor = [UIColor lightGrayColor];
    }
    return _placeHolderLabel;
}

-(void)setConstraint{
    __weak __typeof(&*self)weakSelf = self;
    MAS_CONSTRAINT(self.placeHolderLabel,
                   make.leading.mas_equalTo(10);
                   make.trailing.mas_equalTo(-KCellTrailingOffset);
                   make.centerY.mas_equalTo(weakSelf.textView);
                   );
    
    MAS_CONSTRAINT(self.textView,
                   make.leading.mas_equalTo(5);
                   make.trailing.mas_equalTo(-KCellTrailingOffset);
                   make.height.mas_greaterThanOrEqualTo(33.5);
                   make.top.mas_equalTo(KCellTopOffset);
                   make.centerY.mas_equalTo(weakSelf.contentView);
                   );
}

- (void)setCellWithModel:(JoyTextCellBaseModel *)model{
    self.textView.returnKeyType = UIReturnKeyDone;
    objc_setAssociatedObject(self, @selector(changeFrameWhenTextViewChanged:), model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.changeTextKey = model.changeKey;
    self.textView.keyboardType = model.keyboardType?model.keyboardType:UIKeyboardTypeDefault;
    self.maxNum = model.maxNumber;
    if (self.maxNum && model.subTitle.strLength> self.maxNum)
    {
        model.subTitle  =  [model.subTitle subToMaxIndex:self.maxNum];
    }
    self.textView.text = model.subTitle;
    self.placeHolderLabel.text = model.placeHolder;
    self.placeHolderLabel.hidden = self.textView.text.length;
    CGSize constraintSize = CGSizeMake(KTEXTMaXWIDTH, MAXFLOAT);
    CGSize size = [self.textView sizeThatFits:constraintSize];
    if (size.height >= KTEXTMaXHEIGHT)
    {
        size.height = KTEXTMaXHEIGHT;
    }
    else if (size.height<=KTEXTMINHEIGHT)
    {
        size.height = KTEXTMINHEIGHT;
    }
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(size.height);
    }];
    [self layoutSubviews];
    [self setNeedsUpdateConstraints];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([self.delegate respondsToSelector:@selector(textshouldBeginEditWithTextContainter:andIndexPath:)])
    {
        [self.delegate textshouldBeginEditWithTextContainter:textView andIndexPath:self.index];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if ([self.delegate respondsToSelector:@selector(textshouldEndEditWithTextContainter:andIndexPath:)])
    {
        [self.delegate textshouldEndEditWithTextContainter:textView andIndexPath:self.index];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if ([self.delegate respondsToSelector:@selector(textHasChanged:andText:andChangedKey:)]) {
        [self.delegate textHasChanged:self.index andText:textView.text andChangedKey:self.changeTextKey];
    }
    if (self.maxNum) {
        UITextPosition* beginning = textView.beginningOfDocument;
        UITextRange* markedTextRange = textView.markedTextRange;
        UITextPosition* selectionStart = markedTextRange.start;
        UITextPosition* selectionEnd = markedTextRange.end;
        NSInteger location = [textView offsetFromPosition:beginning toPosition:selectionStart];
        NSInteger length = [textView offsetFromPosition:selectionStart toPosition:selectionEnd];
        NSRange tRange = NSMakeRange(location,length);
        NSString *newString = [textView.text substringWithRange:tRange];
        NSString *oldString = [textView.text stringByReplacingOccurrencesOfString:newString withString:@"" options:0 range:tRange];
        if(newString.length <= 0)//非汉字输入
        {
            if (textView.text.strLength > self.maxNum)
            {textView.text = self.inputOldStr;}
            else
            {self.inputOldStr = textView.text;}
        }
        else//汉字输入
        {
            NSInteger tNewNumber = newString.strLength;
            NSInteger tOldNumber = oldString.strLength;
            BOOL isEnsure = (newString.length*2 == tNewNumber);//判断markedText是汉字还是字母。如果是汉字，说是用户最终输入。
            if(isEnsure && tNewNumber+tOldNumber > self.maxNum)
            {
                NSInteger tIndex = (tNewNumber+tOldNumber) - self.maxNum;
                tIndex = tNewNumber - tIndex;
                tIndex /= 2;
                NSString *finalStr = [oldString substringToIndex:location];
                finalStr = [finalStr stringByAppendingString:[newString substringToIndex:tIndex]];
                finalStr = [finalStr stringByAppendingString:[oldString substringFromIndex:location]];
                textView.text = finalStr;
            }
        }
    }
    self.placeHolderLabel.hidden = textView.text.length;
    [self changeFrameWhenTextViewChanged:textView];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([self.delegate respondsToSelector:@selector(textChanged:andText:andChangedKey:)]) {
        JoyTextCellBaseModel *model = objc_getAssociatedObject(self, @selector(changeFrameWhenTextViewChanged:));
        model.subTitle = textView.text;
        [self.delegate textChanged:self.index andText:textView.text andChangedKey:self.changeTextKey];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if(range.length == 1)
    {return YES;}
    if ((range.location == 0 && [text isEqualToString:@" "]) || [text isEqualToString:@"\n"])
    {return NO;}
    return YES;
}

- (void)changeFrameWhenTextViewChanged:(UITextView *)textView{
    //    [textView flashScrollIndicators];   // 闪动滚动条
    CGSize constraintSize = CGSizeMake(textView.contentSize.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    if (size.height >= KTEXTMaXHEIGHT)
    {
        size.height = KTEXTMaXHEIGHT;
    }
    else if (size.height<=KTEXTMINHEIGHT)
    {
        size.height = KTEXTMINHEIGHT;
    }
    
    if (self.contentView.height-KTEXTTBSPACE != size.height) {
        [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_greaterThanOrEqualTo(size.height);
        }];
        JoyTextCellBaseModel *model = objc_getAssociatedObject(self, @selector(changeFrameWhenTextViewChanged:));
        model.cellH = self.contentView.height;
        [self setNeedsUpdateConstraints];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.scrollBlock?self.scrollBlock(self.index,UITableViewScrollPositionBottom,NO):nil;
            self.beginUpdatesBlock?self.beginUpdatesBlock():nil;
            self.endUpdatesBlock?self.endUpdatesBlock():nil;
        });
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
{
    if (scrollView == self.textView) {
        CGSize constraintSize = CGSizeMake(scrollView.contentSize.width, MAXFLOAT);
        CGSize size = [scrollView sizeThatFits:constraintSize];
        CGFloat contentOfSetY = size.height-scrollView.height;
        scrollView.contentOffset.y != contentOfSetY?[scrollView setContentOffset:CGPointMake(0, contentOfSetY)]:nil;
    }
}

@end
