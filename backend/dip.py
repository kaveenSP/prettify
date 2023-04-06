import torch
import torch.nn as nn
import torchvision.transforms as transforms
from PIL import Image

class DIP(nn.Module):
    def _init_(self, img_path, num_channels=64, num_iterations=5000, learning_rate=0.01, print_interval=100):
        super()._init_()
        self.num_channels = num_channels
        self.num_iterations = num_iterations
        self.learning_rate = learning_rate
        self.print_interval = print_interval

        # Load the image
        self.img = Image.open(img_path)
        self.transform = transforms.Compose([transforms.ToTensor()])
        self.img_tensor = self.transform(self.img)

        # Create a random input image
        self.input_img = torch.randn(self.img_tensor.shape[0], self.num_channels, self.img_tensor.shape[2], self.img_tensor.shape[3])

        # Define the network architecture
        self.net = nn.Sequential(
            nn.Conv2d(self.num_channels, self.num_channels, kernel_size=3, stride=1, padding=1),
            nn.ReLU(),
            nn.Conv2d(self.num_channels, self.num_channels, kernel_size=3, stride=1, padding=1),
            nn.ReLU(),
            nn.Conv2d(self.num_channels, self.num_channels, kernel_size=3, stride=1, padding=1),
            nn.ReLU(),
            nn.Conv2d(self.num_channels, self.img_tensor.shape[0], kernel_size=3, stride=1, padding=1)
        )

    def forward(self, x):
        return self.net(x)

    def optimize(self):
        optimizer = torch.optim.Adam(self.parameters(), lr=self.learning_rate)

        for i in range(self.num_iterations):
            optimizer.zero_grad()
            output = self.forward(self.input_img)
            loss = torch.mean((output - self.img_tensor) ** 2)
            loss.backward()
            optimizer.step()

            if i % self.print_interval == 0:
                print('Iteration {}: loss = {}'.format(i, loss.item()))

        # Convert the output image tensor to a PIL image
        output_img = output.detach().squeeze().permute(1, 2, 0).clamp(0, 1).numpy()
        output_img = (output_img * 255).astype('uint8')
        output_img = Image.fromarray(output_img)

        return output_img