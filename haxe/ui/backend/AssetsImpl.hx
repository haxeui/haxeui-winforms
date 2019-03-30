package haxe.ui.backend;

import cs.system.drawing.Image;
import cs.system.io.MemoryStream;
import haxe.io.Bytes;
import haxe.ui.assets.ImageInfo;

class AssetsImpl extends AssetsBase {
    private override function getImageInternal(resourceId:String, callback:ImageInfo->Void) {
        imageFromBytes(Resource.getBytes(resourceId), callback);
    }

    private override function getImageFromHaxeResource(resourceId:String, callback:String->ImageInfo->Void) {
        imageFromBytes(Resource.getBytes(resourceId), function(imageInfo) {
            callback(resourceId, imageInfo);
        });
    }

    public override function imageFromBytes(bytes:Bytes, callback:ImageInfo->Void) {
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
}