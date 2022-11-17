from mmdet.apis import init_detector, inference_detector

MMDETECTION = "/mmdetection/"

img = MMDETECTION + "demo/demo.jpg"
config_file = MMDETECTION + "/faster_rcnn/" + "faster_rcnn_r50_fpn_1x_coco.py"
checkpoint_file = MMDETECTION + "/checkpoints/" + "faster_rcnn_r50_fpn_1x_coco_20200130-047c8118.pth"

model = init_detector(config_file, checkpoint_file, device="cpu")  # or device="cuda:0"
result = inference_detector(model, img)
model.show_result(img, result, score_thr=0.7, out_file="./tmp.jpg")