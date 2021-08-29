const PgQuery = require("./build/Release/queryparser");

module.exports = {
  parseQuery(query) {
    return new Promise((resolve, reject) => {
      PgQuery.parseQueryAsync(query, (err, result) => {
        err ? reject(err) : resolve(JSON.parse(result));
      });
    });
  },

  parsePlPgSQL(query) {
    return new Promise((resolve, reject) => {
      PgQuery.parsePlPgSQLAsync(query, (err, result) => {
        err ? reject(err) : resolve(JSON.parse(result));
      });
    });
  },

  parseQuerySync(query) {
    return JSON.parse(PgQuery.parseQuerySync(query));
  },

  parsePlPgSQLSync(query) {
    return JSON.parse(PgQuery.parsePlPgSQLSync(query));
  },

  fingerprint(query) {
    return new Promise((resolve, reject) => {
      PgQuery.fingerprintAsync(query, (err, result) => {
        err ? reject(err) : resolve(result);
      });
    });
  },

  fingerprintSync(query) {
    return PgQuery.fingerprintSync(query);
  },

  deparseSync(query) {
    return PgQuery.deparseSync(query);
  },

  normalize(query) {
    return new Promise((resolve, reject) => {
      PgQuery.normalizeAsync(query, (err, result) => {
        err ? reject(err) : resolve(result);
      });
    });
  },

  normalizeSync(query) {
    return PgQuery.normalizeSync(query);
  },
};
