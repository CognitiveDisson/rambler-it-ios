// Copyright (c) 2016 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "LectureCellObjectsBuilderImplementation.h"

#import "LecturePlainObject.h"
#import "LectureModelObject.h"
#import "LocalizedStrings.h"

#import "LectureMaterialTitleTableViewCellObject.h"
#import "LectureDescriptionTableViewCellObject.h"
#import "LectureInfoTableViewCellObject.h"
#import "LectureMaterialTitleTableViewCellObject.h"
#import "LectureMaterialInfoTableViewCellObject.h"
#import "VideoRecordTableViewCellObject.h"

#import "TagObjectDescriptor.h"
#import "TagModuleTableViewCellObject.h"
#import "TagShowMediator.h"

static NSString *const kPresentationImageName = @"ic-presentation";
static NSString *const kArticleImageName = @"ic-article";
static NSString *const kCodeGithubImageName = @"ic-github";
static NSString *const kTimeVideoText = @"(32:12)";

@implementation LectureCellObjectsBuilderImplementation

- (NSArray *)cellObjectsForLecture:(LecturePlainObject *)lecture {
    NSMutableArray *cellObjects = [NSMutableArray new];
    
    LectureInfoTableViewCellObject *lectureDescriptionCellObject = [LectureInfoTableViewCellObject objectWithLecture:lecture];
    [cellObjects addObject:lectureDescriptionCellObject];
    
    TagModuleTableViewCellObject *tagCellObject;
    if (lecture.tags.count > 0) {
        TagObjectDescriptor *objectDescriptor = [[TagObjectDescriptor alloc] initWithObjectName:NSStringFromClass([LectureModelObject class])
                                                                                        idValue:lecture.lectureId];
        tagCellObject = [TagModuleTableViewCellObject objectWithObjectDescriptor:objectDescriptor
                                                                   mediatorInput:[TagShowMediator new]];
        [cellObjects addObject:tagCellObject];
    }
    
    NSString *videoRecordTextTitle = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(VideoRecordTableViewCellTitle, nil), kTimeVideoText];
    LectureMaterialTitleTableViewCellObject *videoRecordTextLabelCellObject = [LectureMaterialTitleTableViewCellObject objectWithText:videoRecordTextTitle];
    [cellObjects addObject:videoRecordTextLabelCellObject];
    
    VideoRecordTableViewCellObject *videoRecordTableViewCellObject = [VideoRecordTableViewCellObject new];
    [cellObjects addObject:videoRecordTableViewCellObject];
    
    LectureMaterialTitleTableViewCellObject *materialsTextLabelCellObject = [LectureMaterialTitleTableViewCellObject objectWithText:NSLocalizedString(LectureMaterialsTableViewCellTitle, nil)];
    [cellObjects addObject:materialsTextLabelCellObject];
    
    UIImage *presentationImage = [UIImage imageNamed:kPresentationImageName];
    LectureMaterialInfoTableViewCellObject *presentationTextImageLabelCellObject = [LectureMaterialInfoTableViewCellObject objectWithText:NSLocalizedString(LecturePresentationTableViewCellTitle, nil) andImage:presentationImage];
    [cellObjects addObject:presentationTextImageLabelCellObject];
    
    UIImage *articleImage = [UIImage imageNamed:kArticleImageName];
    LectureMaterialInfoTableViewCellObject *articlesTextImageLabelCellObject = [LectureMaterialInfoTableViewCellObject objectWithText:NSLocalizedString(LectureArticlesTableViewCellTitle, nil) andImage:articleImage];
    [cellObjects addObject:articlesTextImageLabelCellObject];
    
    LectureMaterialTitleTableViewCellObject *additionalTextLabelCellObject = [LectureMaterialTitleTableViewCellObject objectWithText:NSLocalizedString(AdditionInformationTableViewCellTitle, nil)];
    [cellObjects addObject:additionalTextLabelCellObject];
    
    UIImage *codeGithubImage = [UIImage imageNamed:kCodeGithubImageName];
    LectureMaterialInfoTableViewCellObject *codeGithubTextLabelCellObject = [LectureMaterialInfoTableViewCellObject objectWithText:NSLocalizedString(LectureCodeGithubTableViewCellTitle, nil) andImage:codeGithubImage];
    [cellObjects addObject:codeGithubTextLabelCellObject];
    
    return cellObjects;
}

@end
