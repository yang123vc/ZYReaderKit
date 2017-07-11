//
//  ZYEpubParser.m
//  Pods
//
//  Created by luzhiyong on 2017/7/6.
//
//

#import "ZYEpubParser.h"

#import <SSZipArchive/SSZipArchive.h>

#import <TouchXML/TouchXML.h>

#import "ZYTocReference.h"

@interface ZYEpubParser ()

@property (nonatomic, strong) ZYBook *book;
@property (nonatomic, strong) NSString *bookBasePath;
@property (nonatomic, strong) NSString *resourcesBasePath;

@end

@implementation ZYEpubParser

- (id)init {
    if (self = [super init]) {
        _book = [[ZYBook alloc] init];
    }
    return self;
}

- (UIImage *)parseCoverImage:(NSString *)epubPath unzipPath:(NSString *)unzipPath {
    ZYBook *book = [self readEpub:epubPath unzipPath:unzipPath];
    ZYResource *coverImage = book.coverImage;
    return [[UIImage alloc] initWithContentsOfFile:coverImage.fullHref];
}


- (ZYBook *)readEpub:(NSString *)epubPath unzipPath:(NSString *)unzipPath {
    
    NSString *bookName = epubPath.lastPathComponent;
    
    _bookBasePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    _bookBasePath = [_bookBasePath stringByAppendingPathComponent:bookName];
    
    [SSZipArchive unzipFileAtPath:epubPath toDestination:_bookBasePath];
    
    self.book.name = bookName;
    
    [self readContainer];
    [self readOpf];
    
    return _book;
}

- (void)readContainer {
    NSString *containerPath = @"META-INF/container.xml";
    
    containerPath = [_bookBasePath stringByAppendingPathComponent:containerPath];
    
    NSData *containerData = [[NSData alloc] initWithContentsOfFile:containerPath];
    
    CXMLDocument *document = [[CXMLDocument alloc] initWithData:containerData options:0 error:nil];
    
    ZYResource *opfResource = [ZYResource new];
    
    CXMLNode *opfPath = [document nodeForXPath:@"//@full-path" error:nil];
    
    opfResource.href = [opfPath stringValue];
    
    ZYMediaType *mediaType = [[ZYMediaType alloc] init];
    
#warning 此处需要解析ZYMediaType
    
    _book.opfResource = opfResource;
    _resourcesBasePath = [_bookBasePath stringByAppendingPathComponent:[opfResource.href stringByDeletingLastPathComponent]];
}

- (void)readOpf {
    NSString *opfPath = [_bookBasePath stringByAppendingPathComponent:_book.opfResource.href];
    NSString *identifier ;
    
    NSData *opfData = [NSData dataWithContentsOfFile:opfPath];

    CXMLDocument *document = [[CXMLDocument alloc] initWithData:opfData options:0 error:nil];

    CXMLElement *package = document.children.firstObject;
    if (package) {
        identifier = [[package attributeForName:@"unique-identifier"] stringValue];
        
        NSString *version = [[package attributeForName:@"version"] stringValue];
        if (version) {
            _book.version = [version doubleValue];
        }
    }
    
    NSArray *itemsArray = [document nodesForXPath:@"//opf:item" namespaceMappings:@{@"opf" : @"http://www.idpf.org/2007/opf"} error:nil];
    
    for (CXMLElement *element in itemsArray) {
        ZYResource *resource = [ZYResource new];
        resource.bID = [[element attributeForName:@"id"] stringValue];
        resource.properties = [[element attributeForName:@"properties"] stringValue];
        resource.href = [[element attributeForName:@"href"] stringValue];
        resource.fullHref = [_resourcesBasePath stringByAppendingPathComponent:resource.href];
        
        [_book.resources addResource:resource];
    }
    
    CXMLElement *metadataElement = [document.rootElement elementsForName:@"metadata"].firstObject;
    _book.metadata = [self readMetadata:metadataElement.children];
    
    // Read the book unique identifier
    
    NSString *uniqueIdentifier = [_book.metadata findIdentifierById:identifier];
    if (uniqueIdentifier) {
        _book.uniqueIdentifier = uniqueIdentifier;
    }
    
    // Read the cover image
    NSString *coverImageId = [_book.metadata findMetaByName:@"cover"];
    ZYResource *coverResource = [_book.resources findById:coverImageId];
    
    if (coverResource) {
        _book.coverImage = coverResource;
    } else {
        coverResource = [_book.resources findByProperty:@"cover-image"];
        _book.coverImage = coverResource;
    }
    
    // Specific TOC for epub 2 and 3
    // GET the first resource with the NCX meiatype
    
    ZYResource *tocResource = [_book.resources findByMediaType:ZYMediaTypeInstance.NCX];
    if (tocResource) {
        _book.tocResource = tocResource;
    } else if ((tocResource = [_book.resources findByExtension:ZYMediaTypeInstance.NCX.defaultExtension])) {
        _book.tocResource = tocResource;
    } else if ((tocResource = [_book.resources findByProperty:@"nav"])) {
        _book.tocResource = tocResource;
    }
    
//    NSAssert(_book.tocResource != nil, @"Error: Could not find the table of contents resource.");
    
    // The book TOC
    
    // Read Spine
    CXMLElement *spine = [document.rootElement elementsForName:@"spine"].firstObject;
    _book.spine = [self readSpine:spine.children];
    
}

- (ZYTocReference *)findTableOfContents {
    NSMutableArray *tableOfContent = [NSMutableArray new];
    NSMutableArray *tocItems = [NSMutableArray new];
    
    ZYResource *tocResource = _book.tocResource;
    
    NSString *tocPath = [_resourcesBasePath stringByAppendingPathComponent:tocResource.href];
    
    if ([tocResource.mediaType isEqual:ZYMediaTypeInstance.NCX]) {
        NSData *ncxData = [NSData dataWithContentsOfFile:tocPath];
    } else {
        
    }
    
    return tableOfContent;
}

- (CXMLElement *)findNavTag:(CXMLElement *)element {
    for (CXMLElement *e in element.children) {
        CXMLElement *nav = [e elementsForName:@"nav"].firstObject;
        return nav;
    }
    
    return nil;
}

- (ZYSpine *)readSpine:(NSArray <CXMLElement *>*)tags {
    ZYSpine *spine = [ZYSpine new];
    
    for (CXMLElement *tag in tags) {
        if ([tag isKindOfClass:[CXMLElement class]]) {
            NSString *idref = [tag attributeForName:@"idref"].stringValue;
            BOOL linear = YES;
            
            NSString *linearValue = [tag attributeForName:@"linear"].stringValue;
            if (linearValue) {
                linear = [linearValue isEqualToString:@"yes"] ? YES : NO;
            }
            
            
            if ([_book.resources containsById:idref]) {
                ZYResource *resource = [_book.resources findById:idref];
                Spine *sp = [[Spine alloc] initWithResource:resource linear:linear];
                [spine.spineReferences addObject:sp];
            }
        }
    }
    
    return spine;
}

- (ZYMetadata *)readMetadata:(NSArray <CXMLElement *>*)tags {
    
    ZYMetadata *metadata = [ZYMetadata new];
    
    for (CXMLElement *tag in tags) {
        if ([tag.name isEqualToString:@"dc:title"]) {
            [metadata.titles addObject:tag.stringValue];
        }
        
        if ([tag.name isEqualToString:@"dc:identifier"]) {
            NSString *mId = [tag attributeForName:@"id"].stringValue;
            NSString *scheme = [tag attributeForName:@"opf:scheme"].stringValue;
            NSString *value = tag.stringValue;
            Identifier *identifier = [[Identifier alloc] initWithId:mId scheme:scheme value:value];
            [metadata.identifiers addObject:identifier];
        }
        
        if ([tag.name isEqualToString:@"dc:language"]) {
            NSString *language = tag.stringValue ? tag.stringValue : metadata.language;
            metadata.language = ![language isEqualToString:@"en"] ? language : metadata.language;
        }
        
        if ([tag.name isEqualToString:@"dc:creator"]) {
            NSString *name = tag.stringValue;
            NSString *role = [tag attributeForName:@"opf:role"].stringValue;
            NSString *fileAs = [tag attributeForName:@"opf:file-as"].stringValue;
            Author *author = [[Author alloc] initWithName:name role:role fileAs:fileAs];
            [metadata.creators addObject:author];
        }
        
        if ([tag.name isEqualToString:@"dc:contributor"]) {
            NSString *name = tag.stringValue;
            NSString *role = [tag attributeForName:@"opf:role"].stringValue;
            NSString *fileAs = [tag attributeForName:@"opf:file-as"].stringValue;
            Author *author = [[Author alloc] initWithName:name role:role fileAs:fileAs];
            [metadata.creators addObject:author];
        }
        
        if ([tag.name isEqualToString:@"dc:publisher"]) {
            [metadata.publishers addObject:tag.stringValue ? tag.stringValue : @""];
        }
        
        if ([tag.name isEqualToString:@"dc:description"]) {
            [metadata.descriptions addObject:tag.stringValue ? tag.stringValue : @""];
        }
        
        if ([tag.name isEqualToString:@"dc:subject"]) {
            [metadata.subjects addObject:tag.stringValue ? tag.stringValue : @""];
        }
        
        if ([tag.name isEqualToString:@"dc:rights"]) {
            [metadata.rights addObject:tag.stringValue ? tag.stringValue : @""];
        }
        
        if ([tag.name isEqualToString:@"dc:date"]) {
            Date *date = [[Date alloc] initWithDate:tag.stringValue ? tag.stringValue : @"" event:[tag attributeForName:@"opf:event"].stringValue];
            [metadata.dates addObject:date];
        }
        
        if ([tag.name isEqualToString:@"meta"]) {
            if ([tag attributeForName:@"name"] != nil) {
                NSString *name = [tag attributeForName:@"name"].stringValue;
                NSString *content = [tag attributeForName:@"content"].stringValue;
                Meta *meta = [[Meta alloc] initWithName:name content:content];
                [metadata.metaAttributes addObject:meta];
            }
            
            if ([tag attributeForName:@"property"] != nil && [tag attributeForName:@"id"] != nil) {
                NSString *mId = [tag attributeForName:@"id"].stringValue;
                NSString *property = [tag attributeForName:@"property"].stringValue;
                NSString *value = tag.stringValue;
                Meta *meta = [[Meta alloc] initWithId:mId property:property value:value ? value : @""];
                [metadata.metaAttributes addObject:meta];
            }
            
            if ([tag attributeForName:@"property"] != nil) {
                NSString *property = [tag attributeForName:@"property"].stringValue;
                NSString *value = tag.stringValue;
                NSString *refine = [tag attributeForName:@"refines"].stringValue;
                Meta *meta = [[Meta alloc] initWithProperty:property value:value ? value : @"" refines:refine];
                [metadata.metaAttributes addObject:meta];
            }
        }
    }
    
    return metadata;
}

@end
