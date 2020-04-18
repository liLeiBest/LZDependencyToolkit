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
NSString * stringFromBytesWithLength(unsigned char *bytes, unsigned long length) {
	
	NSMutableString *stringM = [NSMutableString string];
	for (NSInteger i = 0; i < length; i++) {
		[stringM appendFormat:@"%02x", bytes[i]];
	}
	return [NSString stringWithString:stringM];
}

/**
 加解密
 */
NSData * Crypto(NSData *data, NSString *secret, CCOperation operation, size_t keySize, size_t blockSize, CCAlgorithm alg) {
    
    char keyPtr[keySize + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [secret getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
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
 DES 加解密
 */
NSData * DESCrypto(NSData *data, NSString *secret, CCOperation operation) {
    
    NSUInteger length = [secret lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    if (length > kCCKeySizeDES) {
        secret = [secret substringToIndex:kCCKeySizeDES];
    }
	return Crypto(data, secret, operation, kCCKeySizeDES, kCCBlockSizeDES, kCCAlgorithmDES);
}

/**
 3DES 加解密
 */
NSData * TripleDESCrypto(NSData *data, NSString *secret, CCOperation operation) {
    
    NSUInteger length = [secret lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    if (length > kCCKeySize3DES) {
        secret = [secret substringToIndex:kCCKeySize3DES];
    }
    return Crypto(data, secret, operation, kCCKeySize3DES, kCCBlockSize3DES, kCCAlgorithm3DES);
}

// MARK: MD5
NSString * MD5(NSString *plaintext) {
	
	const char *string = plaintext.UTF8String;
	CC_LONG length = (CC_LONG)strlen(string);
	unsigned char bytes[CC_MD5_DIGEST_LENGTH];
	CC_MD5(string, length, bytes);
	return stringFromBytesWithLength(bytes, CC_MD5_DIGEST_LENGTH);
}

// MARK: SHA
NSString * SHA1(NSString *plaintext) {
	
	NSData *data = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
	unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
	CC_SHA1(data.bytes, (CC_LONG)data.length, bytes);
	return stringFromBytesWithLength(bytes, CC_SHA1_DIGEST_LENGTH);
}

NSString * SHA1WithSecret(NSString *plaintext, NSString *secret) {
	
	NSData *keyData = [secret dataUsingEncoding:NSUTF8StringEncoding];
	NSData *plaintextData = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
	NSMutableData *dataM = [NSMutableData dataWithLength:CC_SHA1_DIGEST_LENGTH];
	CCHmac(kCCHmacAlgSHA1,
		   keyData.bytes,
		   keyData.length,
		   plaintextData.bytes,
		   plaintextData.length,
		   dataM.mutableBytes);
	return stringFromBytesWithLength((unsigned char *)dataM.bytes, CC_SHA1_DIGEST_LENGTH);
}

NSString * SHA256(NSString *plaintext) {
	
	const char *string = plaintext.UTF8String;
	unsigned long length = strlen(string);
	unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
	CC_SHA256(string, (CC_LONG)length, bytes);
	return stringFromBytesWithLength(bytes, CC_SHA256_DIGEST_LENGTH);
}

NSString * SHA256WithSecret(NSString *plaintext, NSString *secret) {
	
	NSData *keyData = [secret dataUsingEncoding:NSUTF8StringEncoding];
	NSData *plaintextData = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
	NSMutableData *dataM = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
	CCHmac(kCCHmacAlgSHA256,
		   keyData.bytes,
		   keyData.length,
		   plaintextData.bytes,
		   plaintextData.length,
		   dataM.mutableBytes);
	return stringFromBytesWithLength((unsigned char *)dataM.bytes, CC_SHA256_DIGEST_LENGTH);
}

NSString *SHA512(NSString *plaintext) {
	
	const char *string = plaintext.UTF8String;
	unsigned long length = strlen(string);
	unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
	CC_SHA512(string, (CC_LONG)length, bytes);
	return stringFromBytesWithLength(bytes, CC_SHA512_DIGEST_LENGTH);
}

NSString *SHA512WithSecret(NSString *plaintext, NSString *secret) {
	
	NSData *keyData = [secret dataUsingEncoding:NSUTF8StringEncoding];
	NSData *plaintextData = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
	NSMutableData *dataM = [NSMutableData dataWithLength:CC_SHA512_DIGEST_LENGTH];
	CCHmac(kCCHmacAlgSHA512,
		   keyData.bytes,
		   keyData.length,
		   plaintextData.bytes,
		   plaintextData.length,
		   dataM.mutableBytes);
	return stringFromBytesWithLength((unsigned char *)dataM.bytes, CC_SHA512_DIGEST_LENGTH);
}

// MARK: DES
NSString * DES_Encrypt(NSString *plaintext, NSString *secret) {
	
	NSData *data = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
	data = DESCrypto(data, secret, kCCEncrypt);
	NSString *result = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
	return result;
}

NSString * DES_Decrypt(NSString *ciphertext, NSString *secret) {
	
	NSData *data = [[NSData alloc] initWithBase64EncodedString:ciphertext
													   options:NSDataBase64DecodingIgnoreUnknownCharacters];
	data = DESCrypto(data, secret, kCCDecrypt);
	NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return result;
}

NSString * TDES_Encrypt(NSString *plaintext, NSString *secret) {
    
    NSData *data = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
    data = TripleDESCrypto(data, secret, kCCEncrypt);
    NSString *result = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return result;
}

NSString * TDES_Decrypt(NSString *ciphertext, NSString *secret) {
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:ciphertext
                                                       options:NSDataBase64DecodingIgnoreUnknownCharacters];
    data = TripleDESCrypto(data, secret, kCCDecrypt);
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return result;
}

// MARK: - Initilization
struct LZCryptoUnit_type LZCryptoUnit = {
    
	.MD5 = MD5,
	.SHA1 = SHA1,
	.SHA1WithSecret = SHA1WithSecret,
	.SHA256 = SHA256,
	.SHA256WithSecret = SHA256WithSecret,
	.SHA512 = SHA512,
	.SHA512WithSecret = SHA512WithSecret,
	.DES_Encrypt = DES_Encrypt,
	.DES_Decrypt = DES_Decrypt,
    .TDES_Encrypt = TDES_Encrypt,
    .TDES_Decrypt = TDES_Decrypt,
};
