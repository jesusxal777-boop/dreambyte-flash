package
{
    import flash.display.Sprite;
    import flash.display.Shape;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
    import flash.utils.Timer;
    import flash.events.TimerEvent;

    public class Main extends Sprite
    {
        private var title:TextField;
        private var subtitle:TextField;
        private var enterButton:Sprite;
        private var loading:TextField;

        private var pulseTimer:Timer;

        public function Main()
        {
            stage.frameRate = 30;

            drawBackground();
            drawInterface();
            startLoading();
        }

        private function drawBackground():void
        {
            graphics.beginFill(0x061426);
            graphics.drawRect(0, 0, 800, 600);
            graphics.endFill();

            // Panel central
            graphics.beginFill(0x0A2340);
            graphics.drawRect(70, 70, 660, 460);
            graphics.endFill();

            // Borde azul
            graphics.lineStyle(3, 0x35BFFF);
            graphics.drawRect(70, 70, 660, 460);

            // Líneas decorativas
            graphics.lineStyle(1, 0x1976A8, 0.6);

            for (var y:int = 100; y < 520; y += 30)
            {
                graphics.moveTo(90, y);
                graphics.lineTo(710, y);
            }
        }

        private function drawInterface():void
        {
            title = createText(
                "DREAMBYTE STUDIOS",
                36,
                0x8FE7FF,
                true
            );

            title.x = 0;
            title.y = 125;
            title.width = 800;
            title.autoSize = TextFieldAutoSize.CENTER;
            addChild(title);

            subtitle = createText(
                "FLASH EXPERIMENT 01",
                18,
                0x4ABEFF,
                false
            );

            subtitle.x = 0;
            subtitle.y = 180;
            subtitle.width = 800;
            subtitle.autoSize = TextFieldAutoSize.CENTER;
            addChild(subtitle);

            loading = createText(
                "LOADING...",
                14,
                0xFFFFFF,
                false
            );

            loading.x = 0;
            loading.y = 260;
            loading.width = 800;
            loading.autoSize = TextFieldAutoSize.CENTER;
            addChild(loading);
        }

        private function startLoading():void
        {
            pulseTimer = new Timer(350);
            pulseTimer.addEventListener(
                TimerEvent.TIMER,
                loadingPulse
            );
            pulseTimer.start();

            var delay:Timer = new Timer(2500, 1);

            delay.addEventListener(
                TimerEvent.TIMER_COMPLETE,
                finishLoading
            );

            delay.start();
        }

        private function loadingPulse(event:TimerEvent):void
        {
            if (loading.text == "LOADING...")
                loading.text = "LOADING..";
            else if (loading.text == "LOADING..")
                loading.text = "LOADING.";
            else
                loading.text = "LOADING...";
        }

        private function finishLoading(event:TimerEvent):void
        {
            pulseTimer.stop();

            loading.visible = false;

            createEnterButton();
        }

        private function createEnterButton():void
        {
            enterButton = new Sprite();

            enterButton.graphics.beginFill(0x0879B8);
            enterButton.graphics.drawRoundRect(
                0,
                0,
                180,
                55,
                12,
                12
            );
            enterButton.graphics.endFill();

            enterButton.graphics.lineStyle(
                2,
                0x8FE7FF
            );

            enterButton.graphics.drawRoundRect(
                0,
                0,
                180,
                55,
                12,
                12
            );

            enterButton.x = 310;
            enterButton.y = 330;

            enterButton.buttonMode = true;
            enterButton.mouseChildren = false;

            var buttonText:TextField = createText(
                "ENTER",
                20,
                0xFFFFFF,
                true
            );

            buttonText.x = 0;
            buttonText.y = 15;
            buttonText.width = 180;
            buttonText.autoSize = TextFieldAutoSize.CENTER;

            enterButton.addChild(buttonText);

            enterButton.addEventListener(
                MouseEvent.CLICK,
                enterSite
            );

            enterButton.addEventListener(
                MouseEvent.MOUSE_OVER,
                buttonOver
            );

            enterButton.addEventListener(
                MouseEvent.MOUSE_OUT,
                buttonOut
            );

            addChild(enterButton);
        }

        private function buttonOver(event:MouseEvent):void
        {
            enterButton.alpha = 0.75;
        }

        private function buttonOut(event:MouseEvent):void
        {
            enterButton.alpha = 1;
        }

        private function enterSite(event:MouseEvent):void
        {
            removeChild(enterButton);

            title.text = "WELCOME TO DREAMBYTE";

            subtitle.text =
                "THE FUTURE WAS BUILT IN FLASH";

            var message:TextField = createText(
                "DreamByte Studios\\n\\n" +
                "Flash Experiment 01\\n\\n" +
                "SYSTEM ONLINE",
                18,
                0xDFF8FF,
                false
            );

            message.x = 0;
            message.y = 270;
            message.width = 800;
            message.autoSize = TextFieldAutoSize.CENTER;

            addChild(message);
        }

        private function createText(
            text:String,
            size:int,
            color:uint,
            bold:Boolean
        ):TextField
        {
            var field:TextField = new TextField();

            var format:TextFormat = new TextFormat();

            format.font = "Arial";
            format.size = size;
            format.color = color;
            format.bold = bold;

            field.defaultTextFormat = format;
            field.text = text;
            field.selectable = false;

            return field;
        }
    }
}