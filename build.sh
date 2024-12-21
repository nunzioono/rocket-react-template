# Build frontend and move it as static files into the backend
cd ./frontend
npm install
npm run build
cd ..
mv ./frontend/dist/ ./backend/static/

# Build backend
cd ./backend
cargo build --release
cd ..

# Run docker build
docker build -t backend .