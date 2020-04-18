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
     
     @attention secret 最长 8 位
	 */
	NSString * (* DES_Encrypt)(NSString *plainttext, NSString *secret);
	
	/**
	 DES 解密

     @attention secret 最长 8 位
	 */
	NSString * (* DES_Decrypt)(NSString *ciphertext, NSString *secret);
    
    /**
     3DES 加密

     @param plainttext 明文
     @attention secret 最长 24 位
     */
    NSString * (* TDES_Encrypt)(NSString *plainttext, NSString *secret);
    
    /**
     3DES 解密

     @attention secret 最长 24 位
     */
    NSString * (* TDES_Decrypt)(NSString *ciphertext, NSString *secret);
	
};

FOUNDATION_EXTERN struct LZCryptoUnit_type LZCryptoUnit;

#endif
