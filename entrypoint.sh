#!/bin/sh

PG_LOG=${LOGFILE:-/var/log/pgbouncer}
PG_CONFIG_DIR=/etc/pgbouncer
PG_USER=postgres

if [ ! -f ${PG_CONFIG_DIR}/pgbouncer.ini ]; then
    echo "create pgbouncer config in ${PG_CONFIG_DIR}"
    mkdir -p ${PG_CONFIG_DIR}
    
    if [ -f "${DB_PASSWORD_FILE}" ] ; then
        DB_PASSWORD="$(cat "${DB_PASSWORD_FILE}")"
    fi

echo "# pgbouncer.ini
# Description
# Config file is in 'ini' format. Section names are between '[' and ']'.
# Lines starting with ';' or '#' are taken as comments and ignored.
# The characters ';' and '#' are not recognized when they appear later in the line.
[databases]
* = host=${DB_HOST:?'Setup pgbouncer config error! You must set DB_HOST env'} port=${DB_PORT:-5432} user=${DB_USER:-postgres} ${DB_PASSWORD:+password=${DB_PASSWORD}}
[pgbouncer]
${LOGFILE:+logfile = ${LOGFILE}}
${PIDFILE:+pidfile = ${PIDFILE}}
listen_addr = ${LISTEN_ADDR:-0.0.0.0}
${LISTEN_PORT:+listen_port = ${LISTEN_PORT}}
${UNIX_SOCKET_DIR:+unix_socket_dir = ${UNIX_SOCKET_DIR}}
${UNIX_SOCKET_MODE:+unix_socket_mode = ${UNIX_SOCKET_MODE}}
${UNIX_SOCKET_GROUP:+unix_socket_group = ${UNIX_SOCKET_GROUP}}
${USER:+user = ${USER}}
${AUTH_FILE:+auth_file = ${AUTH_FILE}}
${AUTH_HBA_FILE:+auth_hba_file = ${AUTH_HBA_FILE}}
auth_type = ${AUTH_TYPE:-any}
${AUTH_QUERY:+auth_query = ${AUTH_QUERY}}
${POOL_MODE:+pool_mode = ${POOL_MODE}}
${MAX_CLIENT_CONN:+max_client_conn = ${MAX_CLIENT_CONN}}
${DEFAULT_POOL_SIZE:+default_pool_size = ${DEFAULT_POOL_SIZE}}
${MIN_POOL_SIZE:+min_pool_size = ${MIN_POOL_SIZE}}
${RESERVE_POOL_SIZE:+reserve_pool_size = ${RESERVE_POOL_SIZE}}
${RESERVE_POOL_TIMEOUT:+reserve_pool_timeout = ${RESERVE_POOL_TIMEOUT}}
${MAX_DB_CONNECTIONS:+max_db_connections = ${MAX_DB_CONNECTIONS}}
${MAX_USER_CONNECTIONS:+max_user_connections = ${MAX_USER_CONNECTIONS}}
${SERVER_ROUND_ROBIN:+server_round_robin = ${SERVER_ROUND_ROBIN}}
ignore_startup_parameters = ${IGNORE_STARTUP_PARAMETERS:-extra_float_digits}
${DISABLE_PQEXEC:+disable_pqexec = ${DISABLE_PQEXEC}}
${APPLICATION_NAME_ADD_HOST:+application_name_add_host = ${APPLICATION_NAME_ADD_HOST}}
${CONFFILE:+conffile = ${CONFFILE}}
${JOB_NAME:+job_name = ${JOB_NAME}}
${SYSLOG:+syslog = ${SYSLOG}}
${SYSLOG_IDENT:+syslog_ident = ${SYSLOG_IDENT}}
${SYSLOG_FACILITY:+syslog_facility = ${SYSLOG_FACILITY}}
${LOG_CONNECTIONS:+log_connections = ${LOG_CONNECTIONS}}
${LOG_DISCONNECTIONS:+log_disconnections = ${LOG_DISCONNECTIONS}}
${LOG_POOLER_ERRORS:+log_pooler_errors = ${LOG_POOLER_ERRORS}}
${STATS_PERIOD:+stats_period = ${STATS_PERIOD}}
${VERBOSE:+verbose = ${VERBOSE}}
admin_users = ${ADMIN_USERS:-postgres}
${STATS_USERS:+stats_users = ${STATS_USERS}}
${SERVER_RESET_QUERY:+server_reset_query = ${SERVER_RESET_QUERY}}
${SERVER_RESET_QUERY_ALWAYS:+server_reset_query_always = ${SERVER_RESET_QUERY_ALWAYS}}
${SERVER_CHECK_DELAY:+server_check_delay = ${SERVER_CHECK_DELAY}}
${SERVER_CHECK_QUERY:+server_check_query = ${SERVER_CHECK_QUERY}}
${SERVER_LIFETIME:+server_lifetime = ${SERVER_LIFETIME}}
${SERVER_IDLE_TIMEOUT:+server_idle_timeout = ${SERVER_IDLE_TIMEOUT}}
${SERVER_CONNECT_TIMEOUT:+server_connect_timeout = ${SERVER_CONNECT_TIMEOUT}}
${SERVER_LOGIN_RETRY:+server_login_retry = ${SERVER_LOGIN_RETRY}}
${CLIENT_LOGIN_TIMEOUT:+client_login_timeout = ${CLIENT_LOGIN_TIMEOUT}}
${AUTODB_IDLE_TIMEOUT:+autodb_idle_timeout = ${AUTODB_IDLE_TIMEOUT}}
${DNS_MAX_TTL:+dns_max_ttl = ${DNS_MAX_TTL}}
${DNS_NXDOMAIN_TTL:+dns_nxdomain_ttl = ${DNS_NXDOMAIN_TTL}}
${CLIENT_TLS_SSLMODE:+client_tls_sslmode = ${CLIENT_TLS_SSLMODE}}
${CLIENT_TLS_KEY_FILE:+client_tls_key_file = ${CLIENT_TLS_KEY_FILE}}
${CLIENT_TLS_CERT_FILE:+client_tls_cert_file = ${CLIENT_TLS_CERT_FILE}}
${CLIENT_TLS_CA_FILE:+client_tls_ca_file = ${CLIENT_TLS_CA_FILE}}
${CLIENT_TLS_PROTOCOLS:+client_tls_protocols = ${CLIENT_TLS_PROTOCOLS}}
${CLIENT_TLS_CIPHERS:+client_tls_ciphers = ${CLIENT_TLS_CIPHERS}}
${CLIENT_TLS_ECDHCURVE:+client_tls_ecdhcurve = ${CLIENT_TLS_ECDHCURVE}}
${CLIENT_TLS_DHEPARAMS:+client_tls_dheparams = ${CLIENT_TLS_DHEPARAMS}}
${SERVER_TLS_SSLMODE:+server_tls_sslmode = ${SERVER_TLS_SSLMODE}}
${SERVER_TLS_CA_FILE:+server_tls_ca_file = ${SERVER_TLS_CA_FILE}}
${SERVER_TLS_KEY_FILE:+server_tls_key_file = ${SERVER_TLS_KEY_FILE}}
${SERVER_TLS_CERT_FILE:+server_tls_cert_file = ${SERVER_TLS_CERT_FILE}}
${SERVER_TLS_PROTOCOLS:+server_tls_protocols = ${SERVER_TLS_PROTOCOLS}}
${SERVER_TLS_CIPHERS:+server_tls_ciphers = ${SERVER_TLS_CIPHERS}}
${QUERY_TIMEOUT:+query_timeout = ${QUERY_TIMEOUT}}
${QUERY_WAIT_TIMEOUT:+query_wait_timeout = ${QUERY_WAIT_TIMEOUT}}
${CLIENT_IDLE_TIMEOUT:+client_idle_timeout = ${CLIENT_IDLE_TIMEOUT}}
${IDLE_TRANSACTION_TIMEOUT:+idle_transaction_timeout = ${IDLE_TRANSACTION_TIMEOUT}}
${PKT_BUF:+pkt_buf = ${PKT_BUF}}
${MAX_PACKET_SIZE:+max_packet_size = ${MAX_PACKET_SIZE}}
${LISTEN_BACKLOG:+listen_backlog = ${LISTEN_BACKLOG}}
${SBUF_LOOPCNT:+sbuf_loopcnt = ${SBUF_LOOPCNT}}
${SUSPEND_TIMEOUT:+suspend_timeout = ${SUSPEND_TIMEOUT}}
${TCP_DEFER_ACCEPT:+tcp_defer_accept = ${TCP_DEFER_ACCEPT}}
${TCP_KEEPALIVE:+tcp_keepalive = ${TCP_KEEPALIVE}}
${TCP_KEEPCNT:+tcp_keepcnt = ${TCP_KEEPCNT}}
${TCP_KEEPIDLE:+tcp_keepidle = ${TCP_KEEPIDLE}}
${TCP_KEEPINTVL:+tcp_keepintvl = ${TCP_KEEPINTVL}}" \
| sed -e '/^$/d' \
> ${PG_CONFIG_DIR}/pgbouncer.ini
fi

adduser ${PG_USER}
mkdir -p "${PG_LOG}"
chmod -R 755 "${PG_LOG}"
chown -R ${PG_USER}:${PG_USER} "${PG_LOG}"

if [ -z "$QUIET" ]; then
    cat "${PG_CONFIG_DIR}/pgbouncer.ini"
fi

echo "Starting pgbouncer..."
exec pgbouncer ${QUIET:+-q} -u ${PG_USER} "${PG_CONFIG_DIR}/pgbouncer.ini"
