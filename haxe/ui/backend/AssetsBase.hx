package haxe.ui.backend;

import haxe.io.Bytes;
import haxe.ui.assets.ImageInfo;
import haxe.ui.assets.FontInfo;
import cs.system.drawing.Image;
import cs.system.io.MemoryStream;

class AssetsBase {
    public function new() {

    }

    private function getTextDelegate(resourceId:String):String {
        return null;
    }

    private function getImageInternal(resourceId:String, callback:ImageInfo->Void) {
        imageFromBytes(Resource.getBytes(resourceId), callback);
    }

    private function getImageFromHaxeResource(resourceId:String, callback:String->ImageInfo->Void) {
        imageFromBytes(Resource.getBytes(resourceId), function(imageInfo) {
            callback(resourceId, imageInfo);
        });
    }

    public function imageFromBytes(bytes:Bytes, callback:ImageInfo->Void) {
        if (bytes == null) {
            callback(null);
        }
        
        var stream = new MemoryStream(bytes.getData());
        var image = Image.FromStream(stream);
        var imageInfo:ImageInfo = {
            data: image,
            width: image.Width,
            height: image.Height
        }
        callback(imageInfo);
    }

    private function getFontInternal(resourceId:String, callback:FontInfo->Void) {
        callback(null);
    }

    private function getFontFromHaxeResource(resourceId:String, callback:String->FontInfo->Void) {
        callback(resourceId, null);
    }
}