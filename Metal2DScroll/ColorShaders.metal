//
//	ColorShaders.metal
//	Metal2DScroll
//
//	Created by Kaz Yoshikawa on 12/22/15.
//
//

#include <metal_stdlib>
using namespace metal;


struct VertexIn {
	packed_float4 position [[ attribute(0) ]];
	packed_float4 color [[ attribute(1) ]];
};

struct VertexOut {
	float4 position [[ position ]];
	float4 color;
};

struct Uniforms {
	float4x4 transform;
};

vertex VertexOut color_vertex(
	device VertexIn * vertices [[ buffer(0) ]],
	constant Uniforms & uniforms [[ buffer(1) ]],
	uint vid [[ vertex_id ]]
) {
	VertexOut outVertex;
	VertexIn inVertex = vertices[vid];
	outVertex.position = uniforms.transform * float4(inVertex.position);
	outVertex.color = float4(inVertex.color);
	return outVertex;
}

fragment float4 color_fragment(
	VertexOut vertexIn [[ stage_in ]]
) {
	return vertexIn.color;
}

