#include <napi.h>
#include <string>
#include "sync.h"  // NOLINT(build/include)
#include "helpers.h"  // NOLINT(build/include)

Napi::String ParseQuerySync(const Napi::CallbackInfo& info) {
  std::string query = info[0].As<Napi::String>();
  PgQueryParseResult result = pg_query_parse(query.c_str());

  return QueryParseResult(info.Env(), result);
}

Napi::String ParsePlPgSQLSync(const Napi::CallbackInfo& info) {
  std::string query = info[0].As<Napi::String>();
  PgQueryPlpgsqlParseResult result = pg_query_parse_plpgsql(query.c_str());

  return PlPgSQLParseResult(info.Env(), result);
}

Napi::String FingerprintSync(const Napi::CallbackInfo& info) {
  std::string query = info[0].As<Napi::String>();
  PgQueryFingerprintResult result = pg_query_fingerprint(query.c_str());

  return FingerprintResult(info.Env(), result);
}


Napi::String DeparseSync(const Napi::CallbackInfo& info) {
  std::string query = info[0].As<Napi::String>();
  PgQueryProtobufParseResult result = pg_query_parse_protobuf(query.c_str());
  if (result.error) {
    auto throwVal = CreateError(info.Env(), *result.error);
    pg_query_free_protobuf_parse_result(result);
    throw throwVal;
  }

  PgQueryDeparseResult deparseResult = pg_query_deparse_protobuf(result.parse_tree);
  return DeparseResult(info.Env(), deparseResult);
}

Napi::String NormalizeSync(const Napi::CallbackInfo& info) {
  std::string query = info[0].As<Napi::String>();
  PgQueryNormalizeResult result = pg_query_normalize(query.c_str());

  return NormalizeResult(info.Env(), result);
}
