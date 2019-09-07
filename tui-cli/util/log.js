"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const path = require("path");
const colors = require("colors");
const _ = require("lodash");
const util_1 = require("../util");
exports.LogLevel = {
    ALL: 0,
    TRACE: 1,
    DEBUG: 2,
    INFO: 3,
    TIP: 4,
    WARN: 5,
    ERROR: 6,
    FATAL: 7,
    OFF: 8
};
exports.LogType = {
    'FATAL': {
        color: 'red',
        desc: 'FATAL',
        level: exports.LogLevel.FATAL
    },
    'ERROR': {
        color: 'red',
        desc: 'ERROR',
        level: exports.LogLevel.ERROR
    },
    'WARN': {
        color: 'yellow',
        desc: 'WARN',
        level: exports.LogLevel.WARN
    },
    'CHANGE': {
        color: 'bgYellow',
        desc: '变更',
        level: exports.LogLevel.WARN
    },
    'DELETE': {
        color: 'bgMagenta',
        desc: '删除',
        level: exports.LogLevel.WARN
    },
    'TIP': {
        color: 'magenta',
        desc: '提示',
        level: exports.LogLevel.TIP
    },
    'CREATE': {
        color: 'green',
        desc: '创建',
        level: exports.LogLevel.TIP
    },
    'WATCH': {
        color: 'magenta',
        desc: '监听',
        level: exports.LogLevel.TIP
    },
    'BUILD': {
        color: 'blue',
        desc: '编译',
        level: exports.LogLevel.TIP
    },
    'INFO': {
        color: 'grey',
        desc: '信息',
        level: exports.LogLevel.INFO
    },
    'RUN': {
        color: 'blue',
        desc: '执行',
        level: exports.LogLevel.INFO
    },
    'COMPRESS': {
        color: 'blue',
        desc: '压缩',
        level: exports.LogLevel.INFO
    },
    'COMPLETE': {
        color: 'green',
        desc: '完成',
        level: exports.LogLevel.INFO
    },
    'READ': {
        color: 'green',
        desc: '读取',
        level: exports.LogLevel.INFO
    },
    'WRITE': {
        color: 'green',
        desc: '写入',
        level: exports.LogLevel.INFO
    },
    'GENERATE': {
        color: 'green',
        desc: '生成',
        level: exports.LogLevel.INFO
    },
    'COPY': {
        color: 'yellow',
        desc: '拷贝',
        level: exports.LogLevel.INFO
    },
    'DEBUG': {
        color: 'red',
        desc: '调试',
        level: exports.LogLevel.DEBUG
    },
    'TRACE': {
        color: 'red',
        desc: '跟踪',
        level: exports.LogLevel.TRACE
    }
};
colors.setTheme(exports.LogType);
function getDateTime(date = new Date(), format = 'HH:mm:ss') {
    let fn = (d) => {
        return ('0' + d).slice(-2);
    };
    if (date && _.isString(date)) {
        date = new Date(Date.parse(date));
    }
    const formats = {
        YYYY: date.getFullYear(),
        MM: fn(date.getMonth() + 1),
        DD: fn(date.getDate()),
        HH: fn(date.getHours()),
        mm: fn(date.getMinutes()),
        ss: fn(date.getSeconds())
    };
    return format.replace(/([a-z])\1+/ig, function (a) {
        return formats[a] || a;
    });
}
exports.log = {
    type: exports.LogType,
    fatal(msg) {
        this.msg(exports.LogType.FATAL, msg);
    },
    error(msg) {
        this.msg(exports.LogType.ERROR, msg);
    },
    warn(msg) {
        this.msg(exports.LogType.WARN, msg);
    },
    tip(msg) {
        this.msg(exports.LogType.TIP, msg);
    },
    info(msg) {
        this.msg(exports.LogType.INFO, msg);
    },
    debug(msg) {
        this.msg(exports.LogType.DEBUG, msg);
    },
    msg(logType, msg) {
        if (logType.level < util_1.config.log.level) {
            return;
        }
        let dateTime = util_1.config.log.time
            ? colors.gray(`[${getDateTime()}] `)
            : '';
        if (_.isError(msg)) {
            msg = msg.message;
        }
        else if (_.isPlainObject(msg) || _.isArray(msg)) {
            msg = JSON.stringify(msg);
        }
        if (this.cb) {
            this.cb(msg, logType, dateTime);
        }
        else {
            let color = colors[logType.color];
            msg = dateTime + color(`[${logType.desc}]`) + ' ' + msg;
            if (logType.level >= exports.LogLevel.WARN) {
                console.error(msg);
            }
            else {
                console.log(msg);
            }
        }
    },
    output(logType, msg, file) {
        this.msg(logType, msg + ' in ' + path.relative(util_1.config.cwd, file));
    },
    newline() {
        console.log('');
    },
    register(cb) {
        this.cb = cb;
    },
    unRegister() {
        this.cb = null;
    }
};
