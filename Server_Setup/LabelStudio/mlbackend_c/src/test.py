from mmdet.apis import init_detector, inference_detector

MMDETECTION = "/mmdetection/"

img = MMDETECTION + 'demo/demo.jpg'
config_file = MMDETECTION + 'yolov3_mobilenetv2_320_300e_coco.py'
checkpoint_file = MMDETECTION +'yolov3_mobilenetv2_320_300e_coco_20210719_215349-d18dff72.pth'

model = init_detector(config_file, checkpoint_file, device='cpu')  # or device='cuda:0'
result = inference_detector(model, img)
model.show_result(img, result, score_thr=0.7, out_file='./tmp.jpg')