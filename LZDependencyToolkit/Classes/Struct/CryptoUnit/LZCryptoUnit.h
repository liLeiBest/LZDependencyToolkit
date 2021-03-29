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
	
	// MARK: - SHA
	/**
	 SHA1
	 */
	NSString * (* SHA1)(NSString *plaintext);
	
	/**
	 SHA1
	 */
	NSString * (* SHA1WithSecret)(NSString *plaintext, NSString *secret);
	
	/**
	 SHA256
	 */
	NSString * (* SHA256)(NSString *plaintext);
	
	/**
	 SHA256
	 */
	NSString * (* SHA256WithSecret)(NSString *plaintext, NSString *secret);
	
	/**
	 SHA512
	 */
	NSString * (* SHA512)(NSString *plaintext);
	
	/**
	 SHA512
	 */
	NSString * (* SHA512WithSecret)(NSString *plaintext, NSString *secret);
	
	// MARK: - DES
	/**
	 DES 加密
            
     @attention secret 密钥最长 8 位
	 */
	NSString * (* DES_Encrypt)(NSString *plainttext, NSString *secret);
	
	/**
	 DES 解密
            
     @attention secret 密钥最长 8 位
	 */
	NSString * (* DES_Decrypt)(NSString *ciphertext, NSString *secret);
    
    /**
     3DES 加密
            
     @attention secret 密钥最长 24 位
     */
    NSString * (* TDES_Encrypt)(NSString *plainttext, NSString *secret);
    
    /**
     3DES 解密

     @attention secret 密钥最长 24 位
     */
    NSString * (* TDES_Decrypt)(NSString *ciphertext, NSString *secret);
	
    // MARK: - AES
    /**
     AES-128 加密
     
     @attention 128 bit AES key size，secret 密钥最长 16 位
     */
    NSString * (* AES_Encrypt)(NSString *plainttext, NSString *secret);
    
    /**
     AES-128 解密

     @attention 128 bit AES key size，secret 密钥最长 16 位
     */
    NSString * (* AES_Decrypt)(NSString *ciphertext, NSString *secret);
    
    /**
     AES-192 加密
     
     @attention 192 bit AES key size，secret 密钥最长 16 位
     */
    NSString * (* AES192_Encrypt)(NSString *plainttext, NSString *secret);
    
    /**
     AES-192 解密

     @attention 192 bit AES key size，secret 密钥最长 16 位
     */
    NSString * (* AES192_Decrypt)(NSString *ciphertext, NSString *secret);
    
    /**
     AES-256 加密
     
     @attention 256 bit AES key size，secret 密钥最长 16 位
     */
    NSString * (* AES256_Encrypt)(NSString *plainttext, NSString *secret);
    
    /**
     AES-256 解密

     @attention 256 bit AES key size，secret 密钥最长 16 位
     */
    NSString * (* AES256_Decrypt)(NSString *ciphertext, NSString *secret);
};

FOUNDATION_EXTERN struct LZCryptoUnit_type LZCryptoUnit;

#endif
