//
//  jsc.m
//  Slang
//
//  Created by Tosin Afolabi on 2/11/15.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

// https://github.com/dankogai/swift-jsdemo/blob/master/js/jsc.m

#import <JavaScriptCore/JavaScriptCore.h>

JSValue *getJSVinJSC(JSContext *ctx, NSString *key) {
    return ctx[key];
}

void setJSVinJSC(JSContext *ctx, NSString *key, id val) {
    ctx[key] = val;
}

void setB0JSVinJSC(JSContext *ctx, NSString *key, id (^block)()) {
    ctx[key] = block;
}

void setB1JSVinJSC(JSContext *ctx, NSString *key, id (^block)(id)) {
    ctx[key] = block;
}
void setB2JSVinJSC(JSContext *ctx, NSString *key, id (^block)(id, id)) {
    ctx[key] = block;
}

void setB3JSVinJSC(JSContext *ctx, NSString *key, NSString *secondKey, id (^block)(id)) {
    ctx[key][secondKey] = block;
}
