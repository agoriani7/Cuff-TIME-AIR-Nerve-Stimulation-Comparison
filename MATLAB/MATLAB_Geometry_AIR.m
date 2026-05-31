clear all;
clc;

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Nerve_AIR_Electrode');

comp1 = model.component.create('comp1', true);
geom1 = comp1.geom.create('geom1', 3);
geom1.lengthUnit('mm');

%% Nerve Anatomy
wp1 = geom1.feature.create('wp1', 'WorkPlane');

epi = wp1.geom.feature.create('epi', 'Ellipse');
epi.set('a', 1.5);
epi.set('b', 1.1);

% Fascicles data: [X, Y, a, b, rot]
fascicles_data = [
     0.8,  0.2,  0.30, 0.20,  15;
    -0.6,  0.5,  0.30, 0.20, -20;
    -0.7, -0.4,  0.30, 0.20,   0;
     0.5, -0.6,  0.35, 0.15,  45;
     0.0,  0.0,  0.20, 0.20,   0
];

for i = 1:size(fascicles_data,1)
    f = wp1.geom.feature.create(['fasc', num2str(i)], 'Ellipse');
    f.set('pos', [fascicles_data(i,1), fascicles_data(i,2)]);
    f.set('a', fascicles_data(i,3));
    f.set('b', fascicles_data(i,4));
    f.set('rot', fascicles_data(i,5));
end

ext = geom1.feature.create('ext1', 'Extrude');
ext.selection('input').set({'wp1'});
ext.set('distance', 10);

%% Surrounding Medium
saline = geom1.feature.create('saline', 'Cylinder');
saline.set('r', 35);
saline.set('h', 10);
saline.set('pos', [0 0 0]);

%% AIR electrode parameters
z_center = 5.0;  

spike_penetration_L = 0.6;   
spike_tip_L         = 0.2; % Pt tip
spike_D             = 0.02; % Spike diameter
pitch               = 0.6; % Spike pitch

cuff_thick = 0.1;  
cuff_width = 1.2;   

active_site_r = 0.15; % Radius 
active_site_H = 0.05; % Thickness

nerve_cuff_gap = active_site_H; % Act site touches the nerve

% Increased length for the spikes
spike_total_L = nerve_cuff_gap + spike_penetration_L;
spike_shaft_L = spike_total_L - spike_tip_L;

% Four AIR heads at 90-degree intervals
angles = [0, 90, 180, 270];

for i = 1:length(angles)
    theta = deg2rad(angles(i));

    nx = cos(theta); % Normal vector
    ny = sin(theta);
    tx = -sin(theta); % Tangential vector
    ty =  cos(theta);

    sx = 1.5 * cos(theta);
    sy = 1.1 * sin(theta);

    % Cuff inner face
    cuff_inner_x = sx + nerve_cuff_gap * nx;
    cuff_inner_y = sy + nerve_cuff_gap * ny;

    cuff_head = geom1.feature.create(['cuff_head_', num2str(i)], 'Block');
    cuff_head.set('size', [cuff_width, cuff_thick, cuff_width]);
    cuff_head.set('base', 'center');
    cuff_head.set('pos', [cuff_inner_x + (cuff_thick/2)*nx, cuff_inner_y + (cuff_thick/2)*ny, z_center]);
    cuff_head.set('axistype', 'z');
    cuff_head.set('rot', num2str(angles(i) - 90));

    %% 2. Active sites (Platinum contacts and spikes tips)

    pt_site = geom1.feature.create(['pt_site_', num2str(i)], 'Cylinder');
    pt_site.set('r', active_site_r);
    pt_site.set('h', active_site_H);
    pt_site.set('axis', [-nx, -ny, 0]);   % points toward the nerve
    pt_site.set('pos', [cuff_inner_x, cuff_inner_y, z_center]);

    % Spikes perpendicular to the support
    half_pitch = pitch / 2;

    for s = 1:2
        if s == 1
            sign_t = -1;
        else
            sign_t = +1;
        end

        base_x = cuff_inner_x + sign_t * half_pitch * tx;
        base_y = cuff_inner_y + sign_t * half_pitch * ty;

        spike_idx = (i-1)*2 + s;

        % Spike shaft
        shaft = geom1.feature.create(['spike_shaft_', num2str(spike_idx)], 'Cylinder');
        shaft.set('r', spike_D / 2);
        shaft.set('h', spike_shaft_L);
        shaft.set('axis', [-nx, -ny, 0]);
        shaft.set('pos', [base_x, base_y, z_center]);

        % Pt tip
        tip_x = base_x - spike_shaft_L * nx;
        tip_y = base_y - spike_shaft_L * ny;

        tip = geom1.feature.create(['spike_tip_', num2str(spike_idx)], 'Cylinder');
        tip.set('r', spike_D / 2);
        tip.set('h', spike_tip_L);
        tip.set('axis', [-nx, -ny, 0]);
        tip.set('pos', [tip_x, tip_y, z_center]);
    end
end

%% Build
geom1.run;

%% Materials
saline_mat = model.component('comp1').material.create('sal');
saline_mat.propertyGroup('def').set('electricconductivity', {'2'});

epi_mat = model.component('comp1').material.create('epi');
epi_mat.propertyGroup('def').set('electricconductivity', {'0.0826'});

endo_mat = model.component('comp1').material.create('endo');
endo_mat.propertyGroup('def').set('electricconductivity', {'0.0826','0','0','0','0.0826','0','0','0','0.571'});

poly_mat = model.component('comp1').material.create('poly');
poly_mat.propertyGroup('def').set('electricconductivity', {'6.67e-14'});

pt_mat = model.component('comp1').material.create('pt');
pt_mat.propertyGroup('def').set('electricconductivity', {'8.9e6'});


%% Save
mphgeom(model, 'geom1', 'facealpha', 0.4);
mphsave(model, 'Project_AIR.mph');