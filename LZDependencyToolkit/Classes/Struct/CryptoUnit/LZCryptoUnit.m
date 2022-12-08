//
//  LZCryptoUnit.m
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2019/6/15.
//

#import "LZCryptoUnit.h"
#import <CommonCrypto/CommonCrypto.h>

// MARK: - Private
/// char 转为十六进制字符
NSString * lz_stringFromBytesWithLength(unsigned char * bytes, unsigned long length) {
	
	NSMutableString *stringM = [NSMutableString string];
	for (NSInteger i = 0; i < length; i++) {
		[stringM appendFormat:@"%02x", bytes[i]];
	}
	return [NSString stringWithString:stringM];
}

/// 移除特殊字符
NSString * lz_stringbyRemoveSpecialCharacters(NSString * string) {
    
    NSArray *components = [string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (components && components.count) {
        
        NSMutableString *componentsStrM = [NSMutableString string];
        for (NSString *component in components) {
            if (component && component.length) {
                
                NSString *string = [component stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                if (string && string.length) {
                    [componentsStrM appendString:string];
                }
            }
        }
        string = [componentsStrM copy];
    }
    return string;
}

/// 加解密核心实现
NSData * lz_crypto(NSData *data,
                   NSData *secret,
                   NSData *vector,
                   CCOperation op,
                   CCMode mode,
                   CCAlgorithm alg,
                   CCPadding padding,
                   size_t keySize,
                   size_t blockSize
                   ) {
    
    NSData *returnData = nil;
    
    const void *key = NULL;
    NSData *keyData = secret;
    if (keyData.length != keySize) {
        
        NSMutableData *handleData = keyData.mutableCopy;
        [handleData setLength:keySize];
        keyData = [handleData copy];
    }
    key = keyData.bytes;
    
    const void *iv = NULL;
    if (kCCModeECB != mode && vector) {
        
        NSData *ivData = vector;
        if (ivData.length != keySize) {
            
            NSMutableData *handleData = keyData.mutableCopy;
            [handleData setLength:keySize];
            ivData = [handleData copy];
        }
        iv = ivData.bytes;
    }
    
    CCCryptorRef cryptorRef;
    CCCryptorStatus cryptorStatus = CCCryptorCreateWithMode(op,
                                                            mode,
                                                            alg,
                                                            padding,
                                                            iv,
                                                            key,
                                                            keySize,
                                                            NULL,
                                                            0,
                                                            0,
                                                            0,
                                                            &cryptorRef);
    if (cryptorStatus != kCCSuccess) {
        NSLog(@"Cryptor创建失败:%d", cryptorStatus);
        return returnData;
    }
    
    const void *dataIn = data.bytes;
    size_t dataInLength = [data length];
    
    size_t bufferSize = CCCryptorGetOutputLength(cryptorRef, dataInLength, YES);
    void *buffer = malloc(bufferSize);
    memset(buffer, 0x0, bufferSize);
    size_t bufferUsed = 0;
    size_t bytesTotal = 0;
    
    cryptorStatus = CCCryptorUpdate(cryptorRef,
                                    dataIn,
                                    dataInLength,
                                    buffer,
                                    bufferSize,
                                    &bufferUsed);
    if (cryptorStatus != kCCSuccess) {
        NSLog(@"%@Update失败:%d", kCCEncrypt == op ? @"加密" : @"解密", cryptorStatus);
        free(buffer);
        return returnData;
    }
    
    bytesTotal += bufferUsed;
    if (ccPKCS7Padding == padding) {
        
        cryptorStatus = CCCryptorFinal(cryptorRef,
                                       buffer + bufferUsed,
                                       bufferSize - bufferUsed,
                                       &bufferUsed);
        if (cryptorStatus != kCCSuccess) {
            NSLog(@"%@Final失败:%d", kCCEncrypt == op ? @"加密" : @"解密", cryptorStatus);
            free(buffer);
            return returnData;
        }
        bytesTotal += bufferUsed;
    }
    returnData = [NSData dataWithBytesNoCopy:buffer length:bytesTotal];
    CCCryptorRelease(cryptorRef);
    return returnData;
}

/// 统一加密
NSString * lz_encrypt(NSString *plaintext,
                      id secret,
                      id vector,
                      size_t keySize,
                      size_t blockSize,
                      CCMode mode,
                      CCAlgorithm alg,
                      CCPadding padding,
                      id (* lz_crypto)(NSData *, NSData *, NSData *, CCOperation, CCMode, CCAlgorithm, CCPadding, size_t, size_t)) {
    if (nil == plaintext) return plaintext;
    NSData *plainData = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = nil;
    if (nil != secret) {
        if ([secret isKindOfClass:[NSString class]]) {
            keyData = [secret dataUsingEncoding:NSUTF8StringEncoding];
        } else if ([secret isKindOfClass:[NSData class]]) {
            keyData = (NSData *)secret;
        } else {
            return @"";
        }
    }
    NSData *ivData = nil;
    if (nil != vector) {
        if ([vector isKindOfClass:[NSString class]]) {
            ivData = [vector dataUsingEncoding:NSUTF8StringEncoding];
        } else if ([vector isKindOfClass:[NSData class]]) {
            ivData = (NSData *)vector;
        } else {
            return @"";
        }
    }
    
    NSData *cipherData = lz_crypto(plainData, keyData, ivData, kCCEncrypt, mode, alg, padding, keySize, blockSize);
    if (nil == cipherData) return @"";
    NSString *result = [cipherData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    result = lz_stringbyRemoveSpecialCharacters(result);
    return result;
}

/// 统一解密
NSString * lz_decrypt(NSString *ciphertext,
                      id secret,
                      id vector,
                      size_t keySize,
                      size_t blockSize,
                      CCMode mode,
                      CCAlgorithm alg,
                      CCPadding padding,
                      id (* lz_crypto)(NSData *, NSData *, NSData *, CCOperation, CCMode, CCAlgorithm, CCPadding, size_t, size_t)) {
    if (nil == ciphertext) return ciphertext;
    NSData *cipherData = [[NSData alloc] initWithBase64EncodedString:ciphertext
                                                       options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *keyData = nil;
    if (nil != secret) {
        if ([secret isKindOfClass:[NSString class]]) {
            keyData = [secret dataUsingEncoding:NSUTF8StringEncoding];
        } else if ([secret isKindOfClass:[NSData class]]) {
            keyData = (NSData *)secret;
        } else {
            return @"";
        }
    }
    NSData *ivData = nil;
    if (nil != vector) {
        if ([vector isKindOfClass:[NSString class]]) {
            ivData = [vector dataUsingEncoding:NSUTF8StringEncoding];
        } else if ([vector isKindOfClass:[NSData class]]) {
            ivData = (NSData *)vector;
        } else {
            return @"";
        }
    }
    
    NSData *plainData = lz_crypto(cipherData, keyData, ivData, kCCDecrypt, mode, alg, padding, keySize, blockSize);
    if (nil == plainData) return @"";
    NSString *result = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
    if (nil == result) {
        result = [[NSString alloc] initWithData:plainData encoding:NSASCIIStringEncoding];
    }
    result = result ?: @"";
    return result;
}

// MARK: MD5
NSString * MD5_1(NSString *plaintext, NSData **data) {
    if (nil == plaintext) return plaintext;
    const char *string = plaintext.UTF8String;
    CC_LONG length = (CC_LONG)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    if (nil != data) {
        
        NSMutableData *md5Data = [NSMutableData data];
        [md5Data appendBytes:bytes length:CC_MD5_DIGEST_LENGTH];
        *data = [md5Data copy];
    }
    return lz_stringFromBytesWithLength(bytes, CC_MD5_DIGEST_LENGTH);
}

NSString * MD5(NSString *plaintext) {
    return MD5_1(plaintext, NULL);
}

// MARK: SHA
NSString * SHA1(NSString *plaintext, ...) {
    if (nil == plaintext) return plaintext;
    va_list list;
    va_start(list, plaintext);
    id secret = va_arg(list, NSString *);
    va_end(list);
    
	NSData *plaintextData = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
    if (secret && [secret isKindOfClass:[NSString class]]) {
        
        NSData *keyData = [secret dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableData *dataM = [NSMutableData dataWithLength:CC_SHA1_DIGEST_LENGTH];
        CCHmac(kCCHmacAlgSHA1,
               keyData.bytes,
               keyData.length,
               plaintextData.bytes,
               plaintextData.length,
               dataM.mutableBytes);
        return lz_stringFromBytesWithLength((unsigned char *)dataM.bytes, CC_SHA1_DIGEST_LENGTH);
    } else {
        
        unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
        CC_SHA1(plaintextData.bytes, (CC_LONG)plaintextData.length, bytes);
        return lz_stringFromBytesWithLength(bytes, CC_SHA1_DIGEST_LENGTH);
    }
}

NSString * SHA256(NSString *plaintext, ...) {
    if (nil == plaintext) return plaintext;
    va_list list;
    va_start(list, plaintext);
    id secret = va_arg(list, NSString *);
    va_end(list);
    
    if (secret && [secret isKindOfClass:[NSString class]]) {
        
        NSData *keyData = [secret dataUsingEncoding:NSUTF8StringEncoding];
        NSData *plaintextData = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableData *dataM = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
        CCHmac(kCCHmacAlgSHA256,
               keyData.bytes,
               keyData.length,
               plaintextData.bytes,
               plaintextData.length,
               dataM.mutableBytes);
        return lz_stringFromBytesWithLength((unsigned char *)dataM.bytes, CC_SHA256_DIGEST_LENGTH);
    } else {
        
        const char *string = plaintext.UTF8String;
        unsigned long length = strlen(string);
        unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
        CC_SHA256(string, (CC_LONG)length, bytes);
        return lz_stringFromBytesWithLength(bytes, CC_SHA256_DIGEST_LENGTH);
    }
}

NSString *SHA512(NSString *plaintext, ...) {
    if (nil == plaintext) return plaintext;
    va_list list;
    va_start(list, plaintext);
    id secret = va_arg(list, NSString *);
    va_end(list);
    
    if (secret && [secret isKindOfClass:[NSString class]]) {
        
        NSData *keyData = [secret dataUsingEncoding:NSUTF8StringEncoding];
        NSData *plaintextData = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableData *dataM = [NSMutableData dataWithLength:CC_SHA512_DIGEST_LENGTH];
        CCHmac(kCCHmacAlgSHA512,
               keyData.bytes,
               keyData.length,
               plaintextData.bytes,
               plaintextData.length,
               dataM.mutableBytes);
        return lz_stringFromBytesWithLength((unsigned char *)dataM.bytes, CC_SHA512_DIGEST_LENGTH);
    } else {
        
        const char *string = plaintext.UTF8String;
        unsigned long length = strlen(string);
        unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
        CC_SHA512(string, (CC_LONG)length, bytes);
        return lz_stringFromBytesWithLength(bytes, CC_SHA512_DIGEST_LENGTH);
    }
}

// MARK: DES
NSString * DES_Encrypt(NSString *plaintext, id secret) {
    return lz_encrypt(plaintext,
                      secret,
                      nil,
                      kCCKeySizeDES,
                      kCCBlockSizeDES,
                      kCCModeECB,
                      kCCAlgorithmDES,
                      ccPKCS7Padding,
                      lz_crypto);
}

NSString * DES_Decrypt(NSString *ciphertext, id secret) {
    return lz_decrypt(ciphertext,
                      secret,
                      nil,
                      kCCKeySizeDES,
                      kCCBlockSizeDES,
                      kCCModeECB,
                      kCCAlgorithmDES,
                      ccPKCS7Padding,
                      lz_crypto);
}

NSString * DES_CBC_Encrypt(NSString *plaintext, id secret, id vector) {
    return lz_encrypt(plaintext,
                      secret,
                      vector,
                      kCCKeySizeDES,
                      kCCBlockSizeDES,
                      kCCModeCBC,
                      kCCAlgorithmDES,
                      ccPKCS7Padding,
                      lz_crypto);
}

NSString * DES_CBC_Decrypt(NSString *ciphertext, id secret, id vector) {
    return lz_decrypt(ciphertext,
                      secret,
                      vector,
                      kCCKeySizeDES,
                      kCCBlockSizeDES,
                      kCCModeCBC,
                      kCCAlgorithmDES,
                      ccPKCS7Padding,
                      lz_crypto);
}

NSString * TDES_Encrypt(NSString *plaintext, id secret) {
    return lz_encrypt(plaintext,
                      secret,
                      nil,
                      kCCKeySize3DES,
                      kCCBlockSize3DES,
                      kCCModeECB,
                      kCCAlgorithm3DES,
                      ccPKCS7Padding,
                      lz_crypto);
}

NSString * TDES_Decrypt(NSString *ciphertext, id secret) {
    return lz_decrypt(ciphertext,
                      secret,
                      nil,
                      kCCKeySize3DES,
                      kCCBlockSize3DES,
                      kCCModeECB,
                      kCCAlgorithm3DES,
                      ccPKCS7Padding,
                      lz_crypto);
}

// MARK: AES
NSString * AES_Encrypt(NSString *plaintext, id secret) {
    return lz_encrypt(plaintext,
                      secret,
                      nil,
                      kCCKeySizeAES128,
                      kCCBlockSizeAES128,
                      kCCModeECB,
                      kCCAlgorithmAES,
                      ccPKCS7Padding,
                      lz_crypto);
}

NSString * AES_Decrypt(NSString *ciphertext, id secret) {
    return lz_decrypt(ciphertext,
                      secret,
                      nil,
                      kCCKeySizeAES128,
                      kCCBlockSizeAES128,
                      kCCModeECB,
                      kCCAlgorithmAES,
                      ccPKCS7Padding,
                      lz_crypto);
}

NSString * AES192_Encrypt(NSString *plaintext, id secret) {
    return lz_encrypt(plaintext,
                      secret,
                      nil,
                      kCCKeySizeAES192,
                      kCCBlockSizeAES128,
                      kCCModeECB,
                      kCCAlgorithmAES,
                      ccPKCS7Padding,
                      lz_crypto);
}

NSString * AES192_Decrypt(NSString *ciphertext, id secret) {
    return lz_decrypt(ciphertext,
                      secret,
                      nil,
                      kCCKeySizeAES192,
                      kCCBlockSizeAES128,
                      kCCModeECB,
                      kCCAlgorithmAES,
                      ccPKCS7Padding,
                      lz_crypto);
}

NSString * AES256_Encrypt(NSString *plaintext, id secret) {
    return lz_encrypt(plaintext,
                      secret,
                      nil,
                      kCCKeySizeAES256,
                      kCCBlockSizeAES128,
                      kCCModeECB,
                      kCCAlgorithmAES,
                      ccPKCS7Padding,
                      lz_crypto);
}

NSString * AES256_Decrypt(NSString *ciphertext, id secret) {
    return lz_decrypt(ciphertext,
                      secret,
                      nil,
                      kCCKeySizeAES256,
                      kCCBlockSizeAES128,
                      kCCModeECB,
                      kCCAlgorithmAES,
                      ccPKCS7Padding,
                      lz_crypto);
}

// MARK: - Initilization
struct LZCryptoUnit_type LZCryptoUnit = {
    
	.MD5 = MD5,
    .MD5_1 = MD5_1,
	.SHA1 = SHA1,
	.SHA256 = SHA256,
	.SHA512 = SHA512,
	.DES_Encrypt = DES_Encrypt,
	.DES_Decrypt = DES_Decrypt,
    .DES_CBC_Encrypt = DES_CBC_Encrypt,
    .DES_CBC_Decrypt = DES_CBC_Decrypt,
    .TDES_Encrypt = TDES_Encrypt,
    .TDES_Decrypt = TDES_Decrypt,
    .AES_Encrypt = AES_Encrypt,
    .AES_Decrypt = AES_Decrypt,
    .AES192_Encrypt = AES192_Encrypt,
    .AES192_Decrypt = AES192_Decrypt,
    .AES256_Encrypt = AES256_Encrypt,
    .AES256_Decrypt = AES256_Decrypt,
};
