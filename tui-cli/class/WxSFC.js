"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const class_1 = require("../class");
const util_1 = require("../util");
const path = require("path");
class WxSFC {
    constructor(source, request) {
        this.source = source;
        let { script: { code: scriptCode, compileType: scriptCompileType }, template: { code: templateCode, compileType: templateCompileType }, style: { code: styleCode, compileType: styleCompileType }, wxss: {code:wxssCode,dd_path:dd_path} } = util_1.dom.getSFC(this.source);
        this.script = new class_1.WxSFMScript(scriptCode, request, {
            compileType: scriptCompileType,
            templateCode: templateCode
        });
        let usingComponents = this.script.getUsingComponents();
        this.template = new class_1.WxSFMTemplate(templateCode, request, {
            compileType: templateCompileType,
            usingComponents
        });global.dd_class_WxSFC_17=[styleCode,request,styleCompileType]
        this.style = new class_1.WxSFMStyle(styleCode, request, {
            compileType: styleCompileType
        });
        if(dd_path){
            let request2 = Object.assign( {},request,{
                dest:path.join(request.dest,'../',dd_path)
            } )
            this.wxss = new class_1.WxSFMStyle(wxssCode,request2,{
                compileType: styleCompileType
            })
        }
        
    }
    get sfms() {
        let res = [this.template, this.style, this.script];
        if(this.wxss){
            res.push(this.wxss)
        }
        return res;
    }
    save() {
        this.sfms.forEach(sfm => sfm.save());
        if (this.sfms.length > 0) {
            this.sfms[0].saveStatic();
        }
    }
    remove() {
        this.sfms.forEach(sfm => sfm.remove());
    }
    getDepends() {
        return Array.prototype.concat.apply([], this.sfms.map(sfm => sfm.getDepends()));
    }
    updateDepends(useRequests) {
        this.sfms.forEach(sfm => sfm.updateDepends(useRequests));
    }
}
exports.WxSFC = WxSFC;
