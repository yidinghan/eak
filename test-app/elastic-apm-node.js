module.exports = {
  active: true,
  // Set required app name (allowed characters: a-z, A-Z, 0-9, -, _, and space)
  appName: 'apm-reseach',

  // Use if APM Server requires a token
  secretToken:
    'xxVpmQB2HMzCL9PgBHVrnxjNXXw5J7bd79DFm6sjBJR5HPXDhcF8MSb3vv4bpg44',

  // Set custom APM Server URL (default: http://localhost:8200)
  serverUrl: `http://${process.env.apmserver}:8200`,
};
