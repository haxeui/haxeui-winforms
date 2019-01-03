package haxe.ui.backend;

import haxe.ui.core.Component;
import haxe.ui.geom.Rectangle;
import haxe.ui.assets.ImageInfo;

class ImageDisplayBase {
    public var parentComponent:Component;
    
    private var _left:Float;
    private var _top:Float;
    private var _imageWidth:Float;
    private var _imageHeight:Float;
    private var _imageInfo:ImageInfo;
    private var _imageClipRect:Rectangle;
    
    public function new() {
    }

    private function validateData() {
        
    }
    
    private function validateStyle():Bool {
        return false;
    }
    
    private function validatePosition() {
        
    }
    
    private function validateDisplay() {
        
    }
}