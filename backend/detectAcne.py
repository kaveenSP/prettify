import numpy as np
import torch
import cv2
import matplotlib.pyplot as plt

model = torch.hub.load('ultralytics/yolov5', 'custom', 'acne-detector.pt')

def detect_remove_acne(imagePath):
    image = cv2.imread(imagePath)
    height, width, channels = image.shape
    image = cv2.resize(image, (640, 640))
    mask = np.zeros_like(image)
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB) # convert from BGR to RGB
    results = model(image) # detect objects
    print(results)
    detections = results.xyxy[0]

    # Iterate through the detections and draw bounding boxes
    for detection in detections:
        label = int(detection[5])
        confidence = detection[4]
        bbox = detection[:4]
        x1, y1, x2, y2 = bbox
        print(f'label : {label}, confidence : {confidence}')
        cv2.rectangle(image, (int(x1), int(y1)), (int(x2), int(y2)), (0, 0, 0), cv2.FILLED)
        mask[int(y1):int(y2)+5, int(x1):int(x2)+5] = 255

    cv2.imwrite('localStorage/mask.jpg', cv2.cvtColor(mask, cv2.COLOR_BGR2GRAY))
    cv2.imwrite('localStorage/outImage.jpg', cv2.cvtColor(image, cv2.COLOR_BGR2RGB))

    mask = cv2.cvtColor(mask, cv2.COLOR_BGR2GRAY)

    #inpainting
    image = cv2.inpaint(image, mask, 30, cv2.INPAINT_TELEA)
    image = cv2.resize(image, (width, height))

    # Save the image on local storage
    filePath = "processsedImage.jpg"
    cv2.imwrite(filePath, cv2.cvtColor(image, cv2.COLOR_BGR2RGB))

    return filePath