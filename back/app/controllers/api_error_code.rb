module ApiErrorCode
  ERROR_CODES = {
    sign_out_success: 201,
    fallback: 400,
    unauthenticated: 401,
    token_expired: 401,
    record_not_found: 404,
    auth_token_not_found: 405,
    user_not_found: 406,
    record_invalid: 422,
    validation_errors: 422
  }
  RESPONSE_HEADER_CODES = {
    sign_out_success: 201,
    fallback: 400,
    unauthenticated: 401,
    token_expired: 401,
    record_not_found: 404,
    auth_token_not_found: 405,
    user_not_found: 406,
    record_invalid: 422,
    validation_errors: 422
  }
end
