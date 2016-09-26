



function alertTest()
{
    alert("Test");
}

function loadURL(url) {
    var iFrame;
    iFrame = document.createElement("iframe");
    iFrame.setAttribute("src", url);
    iFrame.setAttribute("style", "display:none;");
    iFrame.parentNode.removeChild(iFrame);
    iFrame = null;
}

function change()
{
    loadURL("yellow://shareClick?title=分享的标题&content=分享的内容&url=链接地址&imagePath=图片地址");
}