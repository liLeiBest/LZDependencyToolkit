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
 DES 加解密
 */
NSData * DESCrypto(NSData *data, NSString *secret, CCOperation operation) {
	
	char keyPtr[kCCKeySizeAES256+1];
	bzero(keyPtr, sizeof(keyPtr));
	[secret getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
	
	NSUInteger dataLength = [data length];
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
	
	size_t numBytesEncrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt(operation,
										  kCCAlgorithmDES,
										  kCCOptionPKCS7Padding | kCCOptionECBMode,
										  keyPtr,
										  kCCBlockSizeDES,
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
};
