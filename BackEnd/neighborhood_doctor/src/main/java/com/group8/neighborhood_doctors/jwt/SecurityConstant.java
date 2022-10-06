package com.group8.neighborhood_doctors.jwt;

public class SecurityConstant {
    public static final String TOKEN_PREFIX= "Bearer ";
    public static final long EXPIRATION_TIME = 30_000;
    public static final String SECRET ="GROUP8_SecretKey";
    public static final String HEADER_STRING = "Authorization";
}
