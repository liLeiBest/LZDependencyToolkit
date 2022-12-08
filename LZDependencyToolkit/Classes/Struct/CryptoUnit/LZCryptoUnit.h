//
//  LZCryptoUnit.h
//  LZDependencyToolkit
//
//  Created by Dear.Q on 2019/6/15.
//

#ifndef LZCryptoUnit_h
#define LZCryptoUnit_h

#import <Foundation/Foundation.h>

struct LZCryptoUnit_type {
	
	// MARK: - MD5
	/**
	 MD5
	 */
	NSString * (* MD5)(NSString *plaintext);
    
    /**
     MD51
     */
    NSString * (* MD5_1)(NSString *plaintext, NSData **data);
	
	// MARK: - SHA
	/**
	 SHA1
     
     @attention 通过可变参数传递 secrect
	 */
	NSString * (* SHA1)(NSString *plaintext, ...);
	
	/**
	 SHA256
     
     @attention 通过可变参数传递 secrect
	 */
	NSString * (* SHA256)(NSString *plaintext, ...);
	
	/**
	 SHA512
     
     @attention 通过可变参数传递 secrect
	 */
	NSString * (* SHA512)(NSString *plaintext, ...);
	
	// MARK: - DES
	/**
	 DES 加密，ECB模式
            
     @attention secret NSString 或者 NSData；密钥最长 8 位
	 */
	NSString * (* DES_Encrypt)(NSString *plainttext, id secret);
	
	/**
	 DES 解密，ECB模式
            
     @attention secret NSString 或者 NSData；密钥最长 8 位
	 */
	NSString * (* DES_Decrypt)(NSString *ciphertext, id secret);
    
    /**
     DES 加密，CBC模式
            
     @attention secret NSString 或者 NSData；密钥最长 8 位
     */
    NSString * (* DES_CBC_Encrypt)(NSString *plainttext, id secret, id vector);
    
    /**
     DES 解密，CBC模式
            
     @attention secret NSString 或者 NSData；密钥最长 8 位
     */
    NSString * (* DES_CBC_Decrypt)(NSString *ciphertext, id secret, id vector);
    
    /**
     3DES 加密
            
     @attention secret NSString 或者 NSData；密钥最长 24 位
     */
    NSString * (* TDES_Encrypt)(NSString *plainttext, id secret);
    
    /**
     3DES 解密

     @attention secret NSString 或者 NSData；密钥最长 24 位
     */
    NSString * (* TDES_Decrypt)(NSString *ciphertext, id secret);
	
    // MARK: - AES
    /**
     AES-128 加密
     
     @attention 128 bit AES key size，secret NSString 或者 NSData；密钥最长 16 位
     */
    NSString * (* AES_Encrypt)(NSString *plainttext, id secret);
    
    /**
     AES-128 解密

     @attention 128 bit AES key size，secret NSString 或者 NSData；密钥最长 16 位
     */
    NSString * (* AES_Decrypt)(NSString *ciphertext, id secret);
    
    /**
     AES-192 加密
     
     @attention 192 bit AES key size，secret NSString 或者 NSData；密钥最长 16 位
     */
    NSString * (* AES192_Encrypt)(NSString *plainttext, id secret);
    
    /**
     AES-192 解密

     @attention 192 bit AES key size，secret NSString 或者 NSData；密钥最长 16 位
     */
    NSString * (* AES192_Decrypt)(NSString *ciphertext, id secret);
    
    /**
     AES-256 加密
     
     @attention 256 bit AES key size，secret NSString 或者 NSData；密钥最长 16 位
     */
    NSString * (* AES256_Encrypt)(NSString *plainttext, id secret);
    
    /**
     AES-256 解密

     @attention 256 bit AES key size，secret NSString 或者 NSData；密钥最长 16 位
     */
    NSString * (* AES256_Decrypt)(NSString *ciphertext, id secret);
};

FOUNDATION_EXTERN struct LZCryptoUnit_type LZCryptoUnit;

#endif
