package com.group8.neighborhood_doctors.jwt;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Hex;

import static com.group8.neighborhood_doctors.jwt.SecurityConstant.SECRET;
import static com.group8.neighborhood_doctors.jwt.SecurityConstant.TOKEN_PREFIX;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;


public class JwtUtility {

    public String HS256(String header, String payload) {
        String HMACSHA256 = "";
        String payload_header = header + "." + payload;

        // Signature
        // https://stackoverflow.com/questions/7124735/hmac-sha256-algorithm-for-signature-calculation
        try {
            Mac sha256_HMAC = Mac.getInstance("HmacSHA256");
            SecretKeySpec secret_key = new SecretKeySpec(SECRET.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
            sha256_HMAC.init(secret_key);
            HMACSHA256 = Hex.encodeHexString(sha256_HMAC.doFinal(payload_header.getBytes(StandardCharsets.UTF_8)));
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (InvalidKeyException e) {
            e.printStackTrace();
        }
        // <>====================<>

        String token = payload_header + "." + HMACSHA256;
        return  token;
    }

    public Boolean verifyToken(String jwt) {
        // Split header + payload
        // Recreate signature
        
        String[] token_contents = jwt.split("\\.");
        String header = token_contents[0];
        header = header.replaceAll(TOKEN_PREFIX, "");

        String payload = token_contents[1];
        
        // In form prefix + header + payload + signature
        String token_expected = TOKEN_PREFIX + HS256(header, payload);
        // Compare newly created token to original token
        //  - if they're the same, return true, otherwise return false
        if (jwt.equals(token_expected)) {
            return true;
        }
        return false;
    }

}
