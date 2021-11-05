//
//  LZCryptoUnit.m
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2019/6/15.
//

#import "LZCryptoUnit.h"
#import <CommonCrypto/CommonCrypto.h>

// MARK: - Private
/**
 char 转为十六进制字符
 */
NSString * _StringFromBytesWithLength(unsigned char * bytes, unsigned long length) {
	
	NSMutableString *stringM = [NSMutableString string];
	for (NSInteger i = 0; i < length; i++) {
		[stringM appendFormat:@"%02x", bytes[i]];
	}
	return [NSString stringWithString:stringM];
}

NSString * _StringbyRemoveSpecialCharacters(NSString * string) {
    
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

/**
 加解密
 */
NSData * _Crypto(NSData *data, id secret,  CCOperation operation, size_t keySize, size_t blockSize, CCAlgorithm alg) {
    
    char keyPtr[keySize + 1];
    bzero(keyPtr, sizeof(keyPtr));
    if (secret && [secret isKindOfClass:[NSString class]] && [(NSString *)secret length]) {
        
        NSUInteger length = [secret lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        if (length > keySize) {
            secret = [secret substringToIndex:keySize];
        }
        [secret getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    } else if (secret && [secret isKindOfClass:[NSData class]]) {
        memcpy(keyPtr, [(NSData *)secret bytes], keySize);
    } else {
        return nil;
    }
    
    size_t bufferSize = 0;
    size_t dataLength = [data length];
    bufferSize = (dataLength + blockSize) & ~(blockSize - 1);
    
    uint8_t *buffer = NULL;
    buffer = malloc(bufferSize * sizeof(uint8_t));
    memset((void *)buffer, 0x0, bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          alg,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,
                                          keySize,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

/**
 统一加密
 */
NSString * _Encrypt(NSString *plaintext, id secret, size_t keySize, size_t blockSize, CCAlgorithm alg, id (* _Crypto)(NSData *data, id secret, CCOperation operation, size_t keySize, size_t blockSize, CCAlgorithm alg)) {
    
    NSData *data = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
    data = _Crypto(data, secret, kCCEncrypt, keySize, blockSize, alg);
    NSString *result = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    result = _StringbyRemoveSpecialCharacters(result);
    return result;
}

/**
 统一解密
 */
NSString * _Decrypt(NSString *ciphertext, id secret, size_t keySize, size_t blockSize, CCAlgorithm alg, id (* _Crypto)(NSData *data, id secret, CCOperation operation, size_t keySize, size_t blockSize, CCAlgorithm alg)) {
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:ciphertext
                                                       options:NSDataBase64DecodingIgnoreUnknownCharacters];
    data = _Crypto(data, secret, kCCDecrypt, keySize, blockSize, alg);
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return result;
}

// MARK: MD5
NSString * MD5_1(NSString *plaintext, NSData **data) {
    
    const char *string = plaintext.UTF8String;
    CC_LONG length = (CC_LONG)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    if (nil != data) {
        
        NSMutableData *md5Data = [NSMutableData data];
        [md5Data appendBytes:bytes length:CC_MD5_DIGEST_LENGTH];
        *data = [md5Data copy];
    }
    return _StringFromBytesWithLength(bytes, CC_MD5_DIGEST_LENGTH);
}

NSString * MD5(NSString *plaintext) {
    return MD5_1(plaintext, NULL);
}

// MARK: SHA
NSString * SHA1(NSString *plaintext, ...) {
	
    va_list list;
    va_start(list, plaintext);
    NSString *secret = va_arg(list, NSString *);
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
        return _StringFromBytesWithLength((unsigned char *)dataM.bytes, CC_SHA1_DIGEST_LENGTH);
    } else {
        
        unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
        CC_SHA1(plaintextData.bytes, (CC_LONG)plaintextData.length, bytes);
        return _StringFromBytesWithLength(bytes, CC_SHA1_DIGEST_LENGTH);
    }
}

NSString * SHA256(NSString *plaintext, ...) {
    
    va_list list;
    va_start(list, plaintext);
    NSString *secret = va_arg(list, NSString *);
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
        return _StringFromBytesWithLength((unsigned char *)dataM.bytes, CC_SHA256_DIGEST_LENGTH);
    } else {
        
        const char *string = plaintext.UTF8String;
        unsigned long length = strlen(string);
        unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
        CC_SHA256(string, (CC_LONG)length, bytes);
        return _StringFromBytesWithLength(bytes, CC_SHA256_DIGEST_LENGTH);
    }
}

NSString *SHA512(NSString *plaintext, ...) {
	
    va_list list;
    va_start(list, plaintext);
    NSString *secret = va_arg(list, NSString *);
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
        return _StringFromBytesWithLength((unsigned char *)dataM.bytes, CC_SHA512_DIGEST_LENGTH);
    } else {
        
        const char *string = plaintext.UTF8String;
        unsigned long length = strlen(string);
        unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
        CC_SHA512(string, (CC_LONG)length, bytes);
        return _StringFromBytesWithLength(bytes, CC_SHA512_DIGEST_LENGTH);
    }
}

// MARK: DES
NSString * DES_Encrypt(NSString *plaintext, NSString *secret) {
    return _Encrypt(plaintext, secret, kCCKeySizeDES, kCCBlockSizeDES, kCCAlgorithmDES, _Crypto);
}

NSString * DES_Decrypt(NSString *ciphertext, NSString *secret) {
    return _Decrypt(ciphertext, secret, kCCKeySizeDES, kCCBlockSizeDES, kCCAlgorithmDES, _Crypto);
}

NSString * TDES_Encrypt(NSString *plaintext, NSString *secret) {
    return _Encrypt(plaintext, secret, kCCKeySize3DES, kCCBlockSize3DES, kCCAlgorithm3DES, _Crypto);
}

NSString * TDES_Decrypt(NSString *ciphertext, NSString *secret) {
    return _Decrypt(ciphertext, secret, kCCKeySize3DES, kCCBlockSize3DES, kCCAlgorithm3DES, _Crypto);
}

// MARK: AES
NSString * AES_Encrypt(NSString *plaintext, NSString *secret) {
    return _Encrypt(plaintext, secret, kCCKeySizeAES128, kCCBlockSizeAES128, kCCAlgorithmAES, _Crypto);
}

NSString * AES_Decrypt(NSString *ciphertext, NSString *secret) {
    return _Decrypt(ciphertext, secret, kCCKeySizeAES128, kCCBlockSizeAES128, kCCAlgorithmAES, _Crypto);
}

NSString * AES192_Encrypt(NSString *plaintext, NSString *secret) {
    return _Encrypt(plaintext, secret, kCCKeySizeAES192, kCCBlockSizeAES128, kCCAlgorithmAES, _Crypto);
}

NSString * AES192_Decrypt(NSString *ciphertext, NSString *secret) {
    return _Decrypt(ciphertext, secret, kCCKeySizeAES192, kCCBlockSizeAES128, kCCAlgorithmAES, _Crypto);
}

NSString * AES256_Encrypt(NSString *plaintext, NSString *secret) {
    return _Encrypt(plaintext, secret, kCCKeySizeAES256, kCCBlockSizeAES128, kCCAlgorithmAES, _Crypto);
}

NSString * AES256_Decrypt(NSString *ciphertext, NSString *secret) {
    return _Decrypt(ciphertext, secret, kCCKeySizeAES256, kCCBlockSizeAES128, kCCAlgorithmAES, _Crypto);
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
    .TDES_Encrypt = TDES_Encrypt,
    .TDES_Decrypt = TDES_Decrypt,
    .AES_Encrypt = AES_Encrypt,
    .AES_Decrypt = AES_Decrypt,
    .AES192_Encrypt = AES192_Encrypt,
    .AES192_Decrypt = AES192_Decrypt,
    .AES256_Encrypt = AES256_Encrypt,
    .AES256_Decrypt = AES256_Decrypt,
};
