//
//  TNATextAndTitleTopDownTableCell.m
//  Toon
//
//  Created by joymake on 16/7/12.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyTextNoLabelCell.h"
#import "JoyCellBaseModel.h"
#import "NSString+JoyCategory.h"
#import "UITextField+JoyCategory.h"
#import "Joy.h"
#import "UIColor+JoyColor.h"

@interface JoyTextNoLabelCell()<UITextFieldDelegate>
@property (strong, nonatomic) UITextField *textField;
@property (nonatomic,copy) NSString *inputOldStr;
@property (nonatomic,copy)NSString *changeTextKey;

@end

@implementation JoyTextNoLabelCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.textField];
        [self setConstraint];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectZero];
        _textField.delegate = self;
        _textField.font = [UIFont systemFontOfSize:14];
    }
    return _textField;
}

-(void)setConstraint{
    __weak __typeof(&*self)weakSelf = self;
    MAS_CONSTRAINT(self.textField, make.leading.mas_equalTo(KCellLeadingOffset);
                   make.trailing.mas_equalTo(-KCellTrailingOffset);
                   make.height.mas_greaterThanOrEqualTo(33.5);
                   make.top.mas_equalTo(KCellTopOffset);
                   make.centerY.mas_equalTo(weakSelf.contentView);
                   );
}

-(void)setCellWithModel:(JoyTextCellBaseModel *)model{
    self.changeTextKey = model.changeKey;
    self.textField.keyboardType = model.keyboardType?model.keyboardType:UIKeyboardTypeDefault;
    self.textField.secureTextEntry = model.secureTextEntry;
    [self.textField setTextMaxNum:model.maxNumber];
    if (self.maxNum && model.title.strLength> self.maxNum) {
        model.title  =  [model.title subToMaxIndex:self.maxNum];
    }
    
    __weak __typeof (&*self)weakSelf = self;
    [self.textField textHasChanged:^{
        [weakSelf textFieldHasChanged];
    }];

    self.textField.text = model.title;
    self.textField.borderStyle = model.borderStyle;
    objc_setAssociatedObject(self, @selector(editingEnd:), model, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, @selector(textFieldDidEndEditing:), model, OBJC_ASSOCIATION_RETAIN);
    self.contentView.userInteractionEnabled = !model.disable;
    
    if(model.placeHolder){
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:model.placeHolder];
        [placeholder addAttribute:NSForegroundColorAttributeName
                            value:UIColorFromRGB(0xCCCCCC)
                            range:NSMakeRange(0, model.placeHolder.length)];
        self.textField.attributedPlaceholder = placeholder;
    }
    if(model.titleColor){
        self.textField.textColor = KJoyHexColor(model.titleColor,1);
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (IBAction)editDidBegin:(id)sender {
}

- (IBAction)editingEnd:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(textChanged:andText:andChangedKey:)]) {
        JoyTextCellBaseModel *model = objc_getAssociatedObject(self, _cmd);
        model.title = textField.text;
        [self.delegate textChanged:self.index andText:textField.text andChangedKey:self.changeTextKey];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(textChanged:andText:andChangedKey:)]) {
        JoyTextCellBaseModel *model = objc_getAssociatedObject(self, _cmd);
        model.title = textField.text;
        [self.delegate textChanged:self.index andText:textField.text andChangedKey:self.changeTextKey];
    }
}

- (void)textFieldHasChanged{
    if ([self.delegate respondsToSelector:@selector(textHasChanged:andText:andChangedKey:)]) {
        [self.delegate textHasChanged:self.index andText:self.textField.text andChangedKey:self.changeTextKey];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([self.delegate respondsToSelector:@selector(textshouldBeginEditWithTextContainter:andIndexPath:)]) {
        [self.delegate textshouldBeginEditWithTextContainter:textView andIndexPath:self.index];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if ([self.delegate respondsToSelector:@selector(textshouldEndEditWithTextContainter:andIndexPath:)]) {
        [self.delegate textshouldEndEditWithTextContainter:textView andIndexPath:self.index];
    }
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(textshouldBeginEditWithTextContainter:andIndexPath:)]) {
        [self.delegate textshouldBeginEditWithTextContainter:textField andIndexPath:self.index];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(textshouldEndEditWithTextContainter:andIndexPath:)]) {
        [self.delegate textshouldEndEditWithTextContainter:textField andIndexPath:self.index];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
