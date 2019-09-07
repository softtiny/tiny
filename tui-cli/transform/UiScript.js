"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const babel = require("babel-core");
const _ = require("lodash");
const util_1 = require("../util");
var t = babel.types;
const lifeCycleMap = {
    mounted: 'onReady'
};
const unsupprotedUiApis = ['openSysMap', 'getDeviceInfo', 'pickPhoneNumber', 'showAlert', 'showConfirm', 'showPrompt', 'showDialog', 'hideDialog', 'hasSplashscreen', 'closeSplashscreen', 'setStatusBarStyle', 'triggerPagePullUp', 'triggerPagePullDown', 'getDeviceInfo', 'useTouchID', 'canUseTouchID', 'onStatusbarTap', 'onBackButtonClick', 'offBackButtonClick', 'setPagePopGesture', 'getQuery', 'openBrowser', 'getPushInfo', 'onPushClick', 'clearPushMessage', 'share', 'startMeiqia', 'getMeiqiaClientId', 'setMeiqiaClientId', 'arrayBufferToBase64', 'base64ToArrayBuffer'];
class UiScript {
    constructor(source, isApp) {
        this.source = source;
        this.isApp = isApp;
        this.source = source;
        this.initNode();
    }
    get config() {
        if (!this._config) {
            let configNode = _.find(this.props, (prop) => {
                return prop.key.name === 'config';
            });
            if (configNode) {
                let result = eval(`({${util_1.scriptAstUtil.transformFromNode(configNode)}})`);
                this._config = result.config;
            }
        }
        return this._config;
    }
    get pages() {
        if (!this._pages) {
            let config = this.config;
            let pages = config.pages;
            let tabs = [];
            if (config.tabBar && config.tabBar.list) {
                tabs = config.tabBar.list.map((item) => item.pagePath);
            }
            this._pages = _.uniq([...pages, ...tabs]);
        }
        return this._pages;
    }
    initNode() {
        this.node = util_1.scriptAstUtil.transform(this.source);
        this.props = util_1.scriptAstUtil.getExportDefaultProperties(this.node);
    }
    generator() {
        return __awaiter(this, void 0, void 0, function* () {
            this.transformProperties();
            this.transformUi();
            if (this.isApp) {
                this.updateConfigPages();
                this.addOnLaunchToApp();
            }
            return this.generateCode();
        });
    }
    transformProperties() {
        let props = this.props;
        for (let i = props.length - 1; i >= 0; i--) {
            let type = props[i].type;
            let keyName = props[i].key.name;
            if (type === 'ObjectMethod' && keyName === 'data') {
                this._tranformData(props, props[i]);
            }
            if (type === 'ObjectProperty' && keyName === 'methods') {
                this._transformMethods(props, props[i], i);
            }
            if (type === 'ObjectMethod' && keyName === 'mounted') {
                this._transformLifeCycle(props[i], keyName);
            }
            if (['created', 'computed', 'watch'].indexOf(keyName) > -1) {
                props.splice(i, 1);
            }
        }
    }
    transformUi() {
        let visitor = {
            Identifier: (path) => {
                if (path.node.name === 'ui') {
                    path.node.name = 'wx';
                }
            },
            ExpressionStatement: (path) => {
                this.vistorExpressionStatement(path);
            }
        };
        babel.traverse(this.node, visitor);
    }
    vistorExpressionStatement(path) {
        let n = path.node;
        if (util_1.scriptAstUtil.isMatchMethods(n, unsupprotedUiApis)) {
            let id = n.expression['callee'].object.name;
            let prop = n.expression['callee'].property.name;
            if (id === 'ui') {
                id = 'wx';
            }
            if (t.isBlockStatement(path.parent)) {
                let body = path.parent.body;
                let index = _.findIndex(body, item => item === n);
                const comment = {
                    type: 'CommentBlock',
                    value: `* TouchUI Tip:小程序不支持此API \n * ${id}.${prop}()\n `
                };
                let prevNode = body[index - 1];
                let nextNode = body[index + 1];
                if (index === 0) {
                    path.parent.innerComments = path.parent.innerComments || [];
                    path.parent.innerComments.push(comment);
                }
                else if (prevNode && !util_1.scriptAstUtil.isMatchMethods(prevNode, unsupprotedUiApis)) {
                    prevNode.trailingComments = prevNode.trailingComments || [];
                    prevNode.trailingComments.push(comment);
                }
                else if (nextNode && !util_1.scriptAstUtil.isMatchMethods(nextNode, unsupprotedUiApis)) {
                    nextNode.leadingComments = nextNode.leadingComments || [];
                    nextNode.leadingComments.push(comment);
                }
                body.splice(index, 1);
            }
        }
    }
    updateConfigPages() {
        let pagesNode = util_1.scriptAstUtil.getNodeFromRootByPath(this.node, 'config.pages');
        pagesNode.value.elements = this.pages.map(page => {
            return { type: 'StringLiteral', value: page };
        });
    }
    addOnLaunchToApp() {
        this.node.program.body.unshift({
            type: 'ImportDeclaration',
            specifiers: [{
                    type: 'ImportDefaultSpecifier',
                    local: {
                        type: 'Identifier',
                        name: 'system'
                    }
                }],
            importKind: 'value',
            source: {
                type: 'StringLiteral',
                value: './static/utils/system'
            }
        });
        this.props.push({
            type: 'ObjectMethod',
            method: true,
            key: {
                type: 'Identifier',
                name: 'onLaunch'
            },
            kind: 'method',
            params: [],
            body: {
                type: 'BlockStatement',
                body: [{
                        type: 'ExpressionStatement',
                        expression: {
                            type: 'CallExpression',
                            callee: {
                                type: 'MemberExpression',
                                object: {
                                    type: 'Identifier',
                                    name: 'system'
                                },
                                property: {
                                    type: 'Identifier',
                                    name: 'attachInfo'
                                }
                            }
                        }
                    }]
            }
        });
    }
    _tranformData(props, data) {
        let dataBody = data.body.body;
        let dataProps = util_1.scriptAstUtil.getReturnObjectProperties(dataBody);
        let globalData = _.find(dataProps, (o) => {
            return o.key.name === 'globalData';
        });
        if (globalData) {
            dataProps = _.filter(dataProps, (o) => {
                return o.key.name !== 'globalData';
            });
        }
        delete data.kind;
        delete data.generator;
        delete data.async;
        delete data.expression;
        delete data.body;
        data.method = false;
        data.type = 'ObjectProperty';
        data.value = {
            type: 'ObjectExpression',
            properties: dataProps
        };
        if (globalData) {
            props.unshift(globalData);
        }
    }
    _transformMethods(props, methods, i) {
        methods.value.properties.forEach((method) => {
            if (!this.isApp) {
                props.push(method);
            }
        });
        props.splice(i, 1);
    }
    _transformLifeCycle(lifeCycle, name) {
        if (lifeCycleMap[name]) {
            lifeCycle.key.name = lifeCycleMap[name];
        }
    }
    generateCode() {
        return util_1.scriptAstUtil.transformFromAst(this.node, (code) => {
            return code.replace(/wx\.getApp\(\)/g, 'getApp()');
        });
    }
}
exports.UiScript = UiScript;
