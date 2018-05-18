//
//  Calibration.swift
//  final_project
//
//  Created by Akshata Sastry on 4/17/17.
//  Copyright © 2017 Akshata Sastry. All rights reserved.
//

import Foundation

/*
var blueRGBVals:[Double] = []
blueRGBVals.append(60.0)
blueRGBVals.append(31.0)
blueRGBVals.append(27.0)

var purpleRGBVals:[Double] = []
purpleRGBVals.append(80.0)
purpleRGBVals.append(51.0)
purpleRGBVals.append(42.0)

var whiteVals:[Double] = []
whiteVals.append(80.0)
whiteVals.append(31.0)
whiteVals.append(28.0)
*/

func calibrateCurve(blueRGBVals: [Double], purpleRGBVals: [Double], whiteVals: [Double]) -> Double {
    
    //THIS SHOULD BE CALLED AFTER ALL THREE CROPS ARE OBTAINED, SO CALIBRATION UNDERNEATH CAN CONTINUE
    
    
    //RGB VALUES ARE INPUT FROM getRGB
    
    var iter:Int = 100
    var total:Double = 0
    var BG:[Double] = []
    var tempB:Double
    var tempW:Double
    var tempP:Double
    var tempBA:[Double] = []
    var tempPA:[Double] = []
    
    for i in 0 ..< 3  {
        //MAYBEHAVE TO CHANGE THIS BACK TO 6
        tempB = blueRGBVals[i]
        tempP = purpleRGBVals[i]
        tempW = whiteVals[i]
        tempBA.append(255 - tempW + tempB)
        tempPA.append(255 - tempW + tempP)
    }
    
    BG.append(newtraphBlueR(iter:iter, vals:tempBA))
    BG.append(newtraphBlueG(iter:iter, vals:tempBA))
    BG.append(newtraphBlueB(iter:iter, vals:tempBA))
    BG.append(newtraphPurpleR(iter:iter, vals:tempPA))
    BG.append(newtraphPurpleG(iter:iter, vals:tempPA))
    BG.append(newtraphPurpleB(iter:iter, vals:tempPA))
    
    for i in 0 ..< 6 {
        total += BG[i]
        print(BG[i])
    }
    
    //print(total)
    return total/6
    
}

func sigR(x:Double, t:Double) -> Double {
    return 78.94 + (208.2/(1+exp(-1*((x-161.7)/(-91.09))))) - t
}

func sigG(x:Double, t:Double) -> Double {
    return 71.86 + (205.3/(1+exp(-1*((x-112)/(-91.48))))) - t
}

func sigB(x:Double, t:Double) -> Double {
    return 109.7 + (121.9/(1+exp(-1*((x-163.6)/(-62.29))))) - t
}

func dsigR(x:Double) -> Double {
    return 208.2*exp((161.7+x)/(-91.09))/(-91.09*(exp(161.7/(-91.09)) + exp(x/(-91.09)))*(exp(161.7/(-91.09)) + exp(x/(-91.09))))
}

func dsigG(x:Double) -> Double {
    return 205.3*exp((112+x)/(-91.48))/(-91.48*(exp(112/(-91.48)) + exp(x/(-91.48)))*(exp(112/(-91.48)) + exp(x/(-91.48))))
}

func dsigB(x:Double) -> Double {
    return 121.9*exp((163.6+x)/(-62.29))/(-62.29*(exp(163.6/(-62.29)) + exp(x/(-62.29)))*(exp(163.6/(-62.29)) + exp(x/(-62.29))))
}

func expR(x:Double, t:Double) -> Double {
    return 191.1*exp(-0.009766*x) + 62.24*exp(-0.0004514*x) - t
}

func expG(x:Double, t:Double) -> Double {
    return 123.8*exp(-0.005929*x) + 127.9*exp(-0.000418*x) - t
}

func expB(x:Double, t:Double) -> Double {
    return 80.97*exp(-0.004578*x) + 156*exp(-0.0003154*x) - t
}

func dexpR(x:Double) -> Double {
    return 191.1*(-0.009766)*exp(-0.009766*x) + 62.24*(-0.0004514)*exp(-0.0004514*x)
}

func dexpG(x:Double) -> Double {
    return 123.8*(-0.005929)*exp(-0.005929*x) + 127.9*(-0.000418)*exp(-0.000418*x)
}

func dexpB(x:Double) -> Double {
    return 80.97*(-0.004578)*exp(-0.004578*x) + 156*(-0.0003154)*exp(-0.0003154*x)
}

func newtraphBlueR(iter:Int, vals: [Double]) -> Double{
    var xrold:Double = 0
    var x:Double = 0
    var ea:Double = 0
    var es:Double = 0
    var maxit:Double = 0
    var t:Double = vals[0]
    var temp:Int = iter
    while(true) {
        xrold = x
        x = x - expR(x: x, t: t)/dexpR(x: x)
        temp = temp + 1
        if (x != 0){
            ea = abs((x - xrold)/x) * 100
        }
        if (ea <= es || Double(temp) >= maxit){
            break
        }
    }
    return x
}

func newtraphBlueG(iter:Int, vals: [Double]) -> Double{
    var xrold:Double = 0
    var x:Double = 0
    var ea:Double = 0
    var es:Double = 0
    var maxit:Double = 0
    var t:Double = vals[1]
    var temp:Int = iter
    while(true) {
        xrold = x
        x = x - expR(x: x, t: t)/dexpR(x: x)
        temp = temp + 1
        if (x != 0){
            ea = abs((x - xrold)/x) * 100
        }
        if (ea <= es || Double(temp) >= maxit){
            break
        }
    }
    return x
}

func newtraphBlueB(iter:Int, vals: [Double]) -> Double{
    var xrold:Double = 0
    var x:Double = 0
    var ea:Double = 0
    var es:Double = 0
    var maxit:Double = 0
    var t:Double = vals[2]
    var temp:Int = iter
    while(true) {
        xrold = x
        x = x - expR(x: x, t: t)/dexpR(x: x)
        temp = temp + 1
        if (x != 0){
            ea = abs((x - xrold)/x) * 100
        }
        if (ea <= es || Double(temp) >= maxit){
            break
        }
    }
    return x
}

func newtraphPurpleR(iter:Int, vals: [Double]) -> Double{
    var xrold:Double = 0
    var x:Double = 0
    var ea:Double = 0
    var es:Double = 0
    var maxit:Double = 0
    var t:Double = vals[0]
    var temp:Int = iter
    while(true) {
        xrold = x
        x = x - expR(x: x, t: t)/dexpR(x: x)
        temp = temp + 1
        if (x != 0){
            ea = abs((x - xrold)/x) * 100
        }
        if (ea <= es || Double(temp) >= maxit){
            break
        }
    }
    return x
}

func newtraphPurpleG(iter:Int, vals: [Double]) -> Double{
    var xrold:Double = 0
    var x:Double = 0
    var ea:Double = 0
    var es:Double = 0
    var maxit:Double = 0
    var t:Double = vals[1]
    var temp:Int = iter
    while(true) {
        xrold = x
        x = x - expR(x: x, t: t)/dexpR(x: x)
        temp = temp + 1
        if (x != 0){
            ea = abs((x - xrold)/x) * 100
        }
        if (ea <= es || Double(temp) >= maxit){
            break
        }
    }
    return x
}


func newtraphPurpleB(iter:Int, vals: [Double]) -> Double{
    var xrold:Double = 0
    var x:Double = 0
    var ea:Double = 0
    var es:Double = 0
    var maxit:Double = 0
    var t:Double = vals[2]
    var temp:Int = iter
    while(true) {
        xrold = x
        x = x - expR(x: x, t: t)/dexpR(x: x)
        temp = temp + 1
        if (x != 0){
            ea = abs((x - xrold)/x) * 100
        }
        if (ea <= es || Double(temp) >= maxit){
            break
        }
    }
    return x
    
}

//calibrateCurve(blueRGBVals:blueRGBVals,purpleRGBVals:purpleRGBVals,whiteVals:whiteVals)

