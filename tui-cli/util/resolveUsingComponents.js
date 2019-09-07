"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const util_1 = require("../util");
const declare_1 = require("../declare");
const excludeTags = ['ui-icon', 'ui-row', 'ui-col', 'ui-row-list'];
function resolveUsingComponents(templateCode) {
    let usingComponents = {};
    if (templateCode) {
        let tree = util_1.dom.make(templateCode);
        let tags = util_1.dom.getTagNamesByRegex(tree, /^(ui(-[\w]+)+)(.*?)/);
        tags.forEach(function (tag) {
            if (!usingComponents[tag] && excludeTags.indexOf(tag) < 0) {
                usingComponents[tag] = util_1.config.projectType === declare_1.ProjectType.Application ? `touchui-wx-components/${tag}` : tag;
            }
        });
    }
    return usingComponents;
}
exports.resolveUsingComponents = resolveUsingComponents;
