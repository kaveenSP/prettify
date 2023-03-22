import torch
import cv2
import matplotlib.pyplot as plt

model = torch.hub.load('ultralytics/yolov5', 'custom', 'best.pt')

image = cv2.imread('lol2.jpeg')
image = cv2.resize(image, (640, 640))
image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB) # convert from BGR to RGB
results = model(image) # detect objects
print(results)
detections = results.xyxy[0]

# Iterate through the detections and draw bounding boxes
for detection in detections:
    print('lol')
    label = int(detection[5])
    confidence = detection[4]
    bbox = detection[:4]
    x1, y1, x2, y2 = bbox
    color = (0, 255, 0)  # Green
    thickness = 2
    cv2.rectangle(image, (int(x1), int(y1)), (int(x2), int(y2)), color, thickness)
    label_text = f"{label} ({confidence:.2f})"
    cv2.putText(image, label_text, (int(x1), int(y1) - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, color, thickness)

# Save the image on local storage
cv2.imwrite("output_image2.jpg", cv2.cvtColor(image, cv2.COLOR_BGR2RGB))

# Display the image with bounding boxes
plt.imshow(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
plt.show()