//
//  SocialLoginResult.swift
//  ReadingFrame
//
//  Created by 석민솔 on 4/14/26.
//


/// 소셜 로그인 처리 결과
enum SocialLoginResult {
    /// 기존 유저: 토큰 발급 성공
    case success(token: String)
    /// 미가입 유저: 회원가입 플로우로 진행 필요
    case needsSignUp
    /// 그 외 실패 (네트워크/서버/디코딩)
    case failure(String)
}
